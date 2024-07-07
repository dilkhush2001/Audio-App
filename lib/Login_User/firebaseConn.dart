// import 'dart:core';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:provider/provider.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AudioPlayerModel(),
//       child: MaterialApp(
//         title: 'Music Player',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: AudioListScreen(),
//       ),
//     );
//   }
// }
//
// class Pair {
//   String path;
//   bool visited;
//   Pair(this.path, this.visited);
//
//   factory Pair.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map<String, dynamic>;
//     return Pair(
//       data['path'] ?? '',
//       data['visited'] ?? false,
//     );
//   }
// }
//
// class AudioPlayerModel with ChangeNotifier {
//   final AudioPlayer _player = AudioPlayer();
//   int _currentTrackIndex = 0;
//   bool _isPlaying = false;
//   double _playbackSpeed = 1.0;
//
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//
//   List<Pair> playlist = [];
//
//   AudioPlayerModel() {
//     _fetchPlaylistFromFirestore();
//     _player.positionStream.listen((position) {
//       _position = position;
//       notifyListeners();
//     });
//     _player.durationStream.listen((duration) {
//       _duration = duration ?? Duration.zero;
//       notifyListeners();
//     });
//     _player.playerStateStream.listen((state) {
//       _isPlaying = state.playing;
//       notifyListeners();
//     });
//   }
//
//   Future<void> _fetchPlaylistFromFirestore() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('audioFiles').get();
//       playlist = querySnapshot.docs.map((doc) => Pair.fromFirestore(doc)).toList();
//       notifyListeners();
//       if (playlist.isNotEmpty) {
//         _loadTrack();
//       }
//     } catch (e) {
//       print('Error fetching playlist: $e');
//     }
//   }
//
//   void _loadTrack() async {
//     if (playlist.isNotEmpty && _currentTrackIndex < playlist.length) {
//       await _player.setAsset(playlist[_currentTrackIndex].path);
//       _player.setSpeed(_playbackSpeed);
//       if (_isPlaying) {
//         _player.play();
//       }
//     }
//   }
//
//   String get currentTrackTitle => 'Audio- ${_currentTrackIndex + 1}';
//   String get currentTrackArtist => 'Artist ${_currentTrackIndex + 1}';
//
//   Duration get duration => _duration;
//   Duration get position => _position;
//
//   String get durationText => _formatDuration(_duration);
//   String get positionText => _formatDuration(_position);
//
//   bool get isPlaying => _isPlaying;
//   double get playbackSpeed => _playbackSpeed;
//
//   int get completedTracks => _currentTrackIndex;
//
//   Future<String> getDurationText(String path) async {
//     final duration = await _getTrackDuration(path);
//     return _formatDuration(duration);
//   }
//
//   void togglePlayPause() {
//     if (_isPlaying) {
//       _player.pause();
//     } else {
//       _player.play();
//     }
//     _isPlaying = !_isPlaying;
//     notifyListeners();
//   }
//
//   void nextTrack(BuildContext context) {
//     if (_position >= _duration) {
//       if (_currentTrackIndex < playlist.length - 1) {
//         playlist[_currentTrackIndex].visited = true; // Mark current track as completed
//         _currentTrackIndex++;
//         _loadTrack();
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('You must complete the current audio to move to the next one.'),
//         ),
//       );
//     }
//   }
//
//   void previousTrack() {
//     if (_currentTrackIndex > 0) {
//       _currentTrackIndex--;
//       _loadTrack();
//     }
//   }
//
//   void loadTrackAtIndex(int index) {
//     _currentTrackIndex = index;
//     _loadTrack();
//   }
//
//   void seek(Duration position) {
//     _player.seek(position);
//   }
//
//   void setPlaybackSpeed(double speed) {
//     _playbackSpeed = speed;
//     _player.setSpeed(speed);
//     notifyListeners();
//   }
//
//   String _formatDuration(Duration duration) {
//     final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }
//
//   Future<Duration> _getTrackDuration(String path) async {
//     // Implement this method to get the duration of the audio file from the path
//     // This might require loading the audio file or using an external package
//     return Duration(seconds: 0); // Dummy duration, replace with actual duration logic
//   }
// }
//
// class AudioListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<AudioPlayerModel>();
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//         title: Text('Audio List'),
//       ),
//       body: Column(
//         children: [
//           CircularProgress(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: model.playlist.length,
//               itemBuilder: (context, index) {
//                 final track = model.playlist[index];
//                 return ListTile(
//                   title: Text('Audio-${index + 1}'),
//                   subtitle: Text(model.durationText),
//                   trailing: IconButton(
//                     icon: Icon(Icons.play_arrow),
//                     onPressed: () {
//                       if (index <= model.completedTracks) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MusicPlayerScreen()),
//                         );
//                         model.loadTrackAtIndex(index);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('You must complete the previous audio to listen to this one.'),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MusicPlayerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//         title: Text('Music Player'),
//       ),
//       backgroundColor: Colors.blueGrey,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           CircularProgress(),
//           SizedBox(height: 20),
//           TrackInfo(),
//           SizedBox(height: 20),
//           ProgressBar(),
//           SizedBox(height: 20),
//           PlayerControls(),
//         ],
//       ),
//     );
//   }
// }
//
// class TrackInfo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<AudioPlayerModel>();
//
//     return Column(
//       children: [
//         Text(
//           model.currentTrackTitle,
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         Text(
//           model.currentTrackArtist,
//           style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
//         ),
//       ],
//     );
//   }
// }
//
// class CircularProgress extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<AudioPlayerModel>();
//     double wi = MediaQuery.of(context).size.width;
//     double hi = MediaQuery.of(context).size.height;
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         CircularPercentIndicator(
//           radius: 150.0,
//           lineWidth: 15.0,
//           percent: model.duration.inSeconds == 0
//               ? 0.0
//               : model.position.inSeconds / model.duration.inSeconds,
//           center: CircularPercentIndicator(
//             center: Container(
//               width: wi * 0.80,
//               height: wi * 0.80,
//               decoration: BoxDecoration(
//                 color: Colors.brown,
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('assets/koyya.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             radius: 135,
//             lineWidth: 20,
//             backgroundColor: Colors.greenAccent,
//           ),
//           progressColor: Colors.blue,
//           backgroundColor: Colors.grey,
//           circularStrokeCap: CircularStrokeCap.round,
//         ),
//       ],
//     );
//   }
// }
//
// class ProgressBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<AudioPlayerModel>();
//
//     return Column(
//       children: [
//         Slider(
//           value: model.position.inSeconds.toDouble(),
//           min: 0.0,
//           max: model.duration.inSeconds.toDouble(),
//           onChanged: (value) {
//             model.seek(Duration(seconds: value.toInt()));
//           },
//         ),
//         Text('${model.positionText} / ${model.durationText}'),
//       ],
//     );
//   }
// }
//
// class PlayerControls extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<AudioPlayerModel>();
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: Icon(Icons.skip_previous),
//           onPressed: () {
//             model.previousTrack();
//           },
//         ),
//         IconButton(
//           icon: Icon(model.isPlaying ? Icons.pause : Icons.play_arrow),
//           onPressed: () {
//             model.togglePlayPause();
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.skip_next),
//           onPressed: () {
//             model.nextTrack(context);
//           },
//         ),
//       ],
//     );
//   }
// }
