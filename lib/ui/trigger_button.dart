import 'dart:async';

import 'package:flutter/material.dart';

import '../sound/dsp/dsp_api.dart';

class TriggerButton extends StatefulWidget {
  final int paramId;
  TriggerButton(this.paramId);
  @override
  State<StatefulWidget> createState() {
    return _State(this.paramId);
  }
}

class _State extends State<StatefulWidget> {
  final int id;
  double _duration = 1;
  Timer? _timer;
  _State(this.id);

  void _setDuration(double newDuration) {
    setState(() {
      _duration = newDuration;
    });
  }

  void _triggerKick() {
    var closeGate = () {
      setState(() {
        _timer = null;
      });
      DspApi.setParamValue(id, 0);
    };
    setState(() {
      _timer?.cancel();
      _timer = Timer(
          Duration(milliseconds: (this._duration * 1000).toInt()), closeGate);
    });
    DspApi.setParamValue(id, 0).then((_) {
      DspApi.setParamValue(id, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          max: 5,
          label: "Trigger duration",
        ),
      ],
    );
  }
}
