import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

void main() {
  runApp(const PushUpApp());
}

class PushUpApp extends StatelessWidget {
  const PushUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '腕立てカウンター',
      home: PushUpCounterScreen(),
    );
  }
}

class PushUpCounterScreen extends StatefulWidget {
  const PushUpCounterScreen({super.key});

  @override
  State<PushUpCounterScreen> createState() => _PushUpCounterScreenState();
}

class _PushUpCounterScreenState extends State<PushUpCounterScreen> {
  int _pushUpCount = 0;
  bool _isNear = false;
  late Stream<bool> _proximityStream;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    // proximity_sensorのStream<int>をboolに変換
    _proximityStream = ProximitySensor.events.map((event) => event > 0);

    _proximityStream.listen((isNear) {
      if (isNear && !_isNear) {
        // 近づいた瞬間にカウントアップ
        setState(() {
          _pushUpCount++;
        });
      }
      _isNear = isNear;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Push-ups',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              '$_pushUpCount',
              style: const TextStyle(fontSize: 80, color: Colors.green),
            ),
            const SizedBox(height: 40),
            const Text(
              'スマホを地面に置いて、\n胸を近づけるとカウントされます！',
              style: TextStyle(fontSize: 18, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
