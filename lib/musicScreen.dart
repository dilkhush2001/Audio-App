import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'music.dart';
class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AudioPlayerModel>();
    double wi = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        model.isPlaying
            ? AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * 3.14,
              child: CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 15.0,
                percent: model.position.inSeconds / model.duration.inSeconds,
                startAngle: 75,
                center: CircularPercentIndicator(
                  center: Container(
                    width: wi * 0.80,
                    height: wi * 0.80,
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/round.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  radius: 135,
                  lineWidth: 20,
                  backgroundColor: Colors.greenAccent,
                ),
                progressColor: Colors.blue,
                backgroundColor: Colors.grey,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            );
          },
        )
            : CircularPercentIndicator(
          radius: 150.0,
          lineWidth: 15.0,
          percent: model.position.inSeconds / model.duration.inSeconds,
          startAngle: 75,
          center: CircularPercentIndicator(
            center: Container(
              width: wi * 0.80,
              height: wi * 0.80,
              decoration: const BoxDecoration(
                color: Colors.brown,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/offaudio.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            radius: 135,
            lineWidth: 20,
            backgroundColor: Colors.greenAccent,
          ),
          progressColor: Colors.blue,
          backgroundColor: Colors.grey,
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ],
    );
  }
}
