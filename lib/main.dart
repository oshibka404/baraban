import 'dart:async';

import 'package:flutter/material.dart';
import 'dsp_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faust Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key = const Key('HomePage')}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _duration = 0.2;
  Timer? _timer;

  @override
  void initState() {
    DspApi.start();
    super.initState();
  }

  void _triggerKick() {
    var closeGate = () {
      setState(() {
        _timer = null;
      });
      DspApi.setParamValueByPath('/main/kick/gate', 0);
    };
    setState(() {
      _timer?.cancel();
      _timer =
          Timer(Duration(milliseconds: (_duration * 1000).toInt()), closeGate);
    });
    DspApi.setParamValueByPath('/main/kick/gate', 0).then((_) {
      DspApi.setParamValueByPath('/main/kick/gate', 1);
    });
  }

  void _setDuration(double newDuration) {
    setState(() {
      _duration = newDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _triggerKick,
              child: Text('Kick!'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      _timer != null ? Colors.red : Colors.amber)),
            ),
            Slider(
              value: _duration,
              onChanged: _setDuration,
              min: 0.01,
              max: 1,
              label: "Trigger duration",
            ),
          ],
        ),
      ),
    );
  }
}
