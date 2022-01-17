import 'dart:async';

import 'package:faust_flutter/ui/param_slider.dart';
import 'package:flutter/material.dart';
import 'sound/dsp/dsp_api.dart';
import 'sound/dsp/dsp_param_ids.dart';

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
  double _pitch = 100;
  double _click = 0.1;
  double _attack = 0.1;
  double _decay = 0.5;
  double _drive = 2;
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
      DspApi.setParamValue(DspParamIds.kick_gate, 0);
    };
    setState(() {
      _timer?.cancel();
      _timer =
          Timer(Duration(milliseconds: (_duration * 1000).toInt()), closeGate);
    });
    DspApi.setParamValue(DspParamIds.kick_gate, 0).then((_) {
      DspApi.setParamValue(DspParamIds.kick_gate, 1);
    });
  }

  void _setPitch(double pitch) {
    setState(() {
      _pitch = pitch;
    });
    DspApi.setParamValue(DspParamIds.kick_pitch, pitch);
  }

  void _setClick(double click) {
    setState(() {
      _click = click;
    });
    DspApi.setParamValue(DspParamIds.kick_click, click);
  }

  void _setAttack(double attack) {
    setState(() {
      _attack = attack;
    });
    DspApi.setParamValue(DspParamIds.kick_attack, attack);
  }

  void _setDecay(double decay) {
    setState(() {
      _decay = decay;
    });
    DspApi.setParamValue(DspParamIds.kick_decay, decay);
  }

  void _setDrive(double drive) {
    setState(() {
      _drive = drive;
    });
    DspApi.setParamValue(DspParamIds.kick_drive, drive);
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
            Text("Trigger duration: ${_duration.toStringAsPrecision(3)} sec"),
            Slider(
              value: _duration,
              onChanged: _setDuration,
              min: 0.01,
              max: 1,
              label: "Trigger duration",
            ),
            DspParamSlider(DspParamIds.kick_pitch),
            Text("Click: ${_click.toStringAsPrecision(3)} sec"),
            Slider(
              value: _click,
              onChanged: _setClick,
              min: 0.005,
              max: 1,
              label: "Click",
            ),
            Text("Attack: ${_attack.toStringAsPrecision(3)} sec"),
            Slider(
              value: _attack,
              onChanged: _setAttack,
              min: 0.005,
              max: 1,
              label: "Attack",
            ),
            Text("Decay: ${_decay.toStringAsPrecision(3)} sec"),
            Slider(
              value: _decay,
              onChanged: _setDecay,
              min: 0.01,
              max: 4,
              label: "Decay",
            ),
            Text("Drive: ${_drive.toStringAsPrecision(2)}x"),
            Slider(
              value: _drive,
              onChanged: _setDrive,
              min: 1,
              max: 10,
              label: "Drive",
            ),
          ],
        ),
      ),
    );
  }
}
