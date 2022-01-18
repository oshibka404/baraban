import 'package:faust_flutter/sound/dsp/dsp_param_ids.dart';
import 'package:faust_flutter/ui/drum.dart';
import 'package:flutter/material.dart';
import 'sound/dsp/dsp_api.dart';

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
  @override
  void initState() {
    DspApi.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Drum(DspParamIds.kick_gate, [
          DspParamIds.kick_pitch,
          DspParamIds.kick_click,
          DspParamIds.kick_attack,
          DspParamIds.kick_decay,
          DspParamIds.kick_drive,
        ]),
      ),
    );
  }
}
