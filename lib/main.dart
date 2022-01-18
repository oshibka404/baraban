import 'package:faust_flutter/ui/param_slider.dart';
import 'package:faust_flutter/ui/trigger_button.dart';
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
  @override
  void initState() {
    DspApi.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TriggerButton(DspParamIds.kick_gate),
            DspParamSlider(DspParamIds.kick_pitch),
            DspParamSlider(DspParamIds.kick_click),
            DspParamSlider(DspParamIds.kick_attack),
            DspParamSlider(DspParamIds.kick_decay),
            DspParamSlider(DspParamIds.kick_drive),
          ],
        ),
      ),
    );
  }
}
