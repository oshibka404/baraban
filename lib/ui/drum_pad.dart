import 'package:flutter/material.dart';

import '../sound/dsp/dsp_api.dart';

class DrumPad extends StatefulWidget {
  final int paramId;
  DrumPad(this.paramId);
  @override
  State<StatefulWidget> createState() {
    return _State(this.paramId);
  }
}

class _State extends State<StatefulWidget> {
  final int id;
  bool _gate = false;
  _State(this.id);

  void onTapDown(TapDownDetails event) {
    setState(() {
      _gate = true;
    });
    DspApi.setParamValue(id, 1);
  }

  void onTapUp(TapUpDetails event) {
    setState(() {
      _gate = false;
    });
    DspApi.setParamValue(id, 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(color: _gate ? Colors.redAccent : Colors.red),
      ),
      onTapDown: onTapDown,
      onTapUp: onTapUp,
    );
  }
}
