
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Audio List'),
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
