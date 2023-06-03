import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:stop_watch/buttons.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const MyApp(), 
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home:  const StopwatchPage(),
    );
  }
}
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.remainder(60).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return '$hours:$minutes:$seconds:$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      appBar: AppBar(
         backgroundColor: Colors.black,
        title: const Text('Stopwatch',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const  SizedBox(height: 200,),
            Text(
              _formatDuration(_stopwatch.elapsed),
              style:const TextStyle(
                    color: Colors.white, fontSize: 50, letterSpacing: 5),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _startTimer(),
                    child: const StartButton(name: "Start")),
                   GestureDetector(
                    onTap: () => _stopTimer(),
                    child: const StopButton(name: "Stop")),
                    GestureDetector(
                    onTap: () => _resetTimer(),
                    child: const ResetButton(name: "Reset")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}