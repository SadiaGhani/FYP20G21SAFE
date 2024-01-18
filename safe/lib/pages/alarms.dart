import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AlarmsPage extends StatefulWidget {
  AlarmsPage({super.key});

  @override
  _AlarmsPageState createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isRinging = false;

  // Function to handle the start ringing action
  void startRinging() async {
    try {
      await _audioPlayer.setAsset('assets/tune.mp3');
      await _audioPlayer.play();
      setState(() {
        isRinging = true;
      });
      print('Alarm is ringing!');
    } catch (e) {
      print('Error starting ringing: $e');
    }
  }

  // Function to handle the stop ringing action
  void stopRinging() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        isRinging = false;
      });
      print('Alarm stopped ringing');
    } catch (e) {
      print('Error stopping ringing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        children: [
          Positioned(
            left: -15,
            top: 0,
            child: Image.asset(
              'assets/upr_corner.png',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            right: -15,
            top: 0,
            child: Image.asset(
              'assets/safe_logo.png',
              width: 130,
              height: 130,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: startRinging,
                child: Text('Start Ringing'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: isRinging ? stopRinging : null,
                child: Text('Stop Ringing'),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Color(0XFF93BFCF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Activate your Alarm now',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/alarms.png',
                        width: 130,
                        height: 130,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -15,
            bottom: 0,
            child: Image.asset(
              'assets/btm_corner.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}