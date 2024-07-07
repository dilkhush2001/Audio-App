import 'package:flutter/material.dart';
class Message extends StatefulWidget {
  const Message({super.key});
  @override
  State<Message> createState() => _MessageState();
}
class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepOrange,
        body: Container(
          margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),topRight: Radius.circular(26)
            )
          ),
          child:  Column(
            children: [
              const ListTile(
                title: Text('Favorites contact'),
                trailing: Icon(Icons.more_horiz),
              ),
              Container(
                  height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 40,backgroundColor: Colors.yellowAccent,),
                        SizedBox(height: 5,),
                        Text('title')
                      ],
                    ),
                  );
                },
                ),
              ),
              Expanded(child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child:  const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(radius: 35,),
                              SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dilkhus', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                                  Text('Dilkhus devleoer yae you have to do it', style: TextStyle(fontSize: 14, color: Colors.black45),),
                                ],
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              Text('4:20 PM'),
                              SizedBox(height: 4,),
                              Text('NEW ', style: TextStyle(color: Colors.red),)
                            ],
                          ),
                        ],

                      ),
                    ),
                  );
                },))
            ],
          ),
        ),
    );
  }
}
