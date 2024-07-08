
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:provider/provider.dart';
import 'Login_User/PaymentGatway.dart';
import 'Payment Gateway/home_screen.dart';
import 'main.dart';
import 'music.dart';
import 'musicScreen.dart';

class AudioListScreen extends StatelessWidget {
  const AudioListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AudioPlayerModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Audio List'),
        actions: [
          ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                PaypalCheckout(
                  sandboxMode: true,
                  clientId: "u can give ur or else i will send u personal",
                  secretKey: "SAme .......",
                  returnURL: "www.google.com",
                  cancelURL: "www.google.com",
                  transactions: const [
                    {
                      "amount": {
                        "total": '70',
                        "currency": "USD",
                        "details": {
                          "subtotal": '70',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      "item_list": {
                        "items": [
                          {
                            "name": "Apple",
                            "quantity": 4,
                            "price": '5',
                            "currency": "USD"
                          },
                          {
                            "name": "Pineapple",
                            "quantity": 5,
                            "price": '10',
                            "currency": "USD"
                          }
                        ],
                        
                        "shipping_address": {
                          "recipient_name": "Dilkhush Rahi",
                          "line1": "Bihar",
                          "line2": "",
                          "city": "Katihar",
                          "country_code": "IN",
                          "postal_code": "11001",
                          "phone": "+00000000",
                          "state": "Texas"
                        },
                      }
                    }
                  ],
                  note: "PAYMENT_NOTE",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");
                  },
                  onError: (error) {
                    print("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('cancelled:');
                  },
                ),

          ));}, child: Text('Subsciption', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MusicScreen(),
          ),
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(40),
            ),
              child: Center(child: Text("Audio PlayList...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))),
          Expanded(
            child: ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                final track = playlist[index];
                return ListTile(
                  title: Text('Audio-${index + 1}', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(model.durationText),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      if (index == 0 || playlist[index - 1].vis) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MusicPlayerScreen()),
                        );
                        model.loadTrackAtIndex(index);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You must complete the previous audio to listen to this one.'),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

