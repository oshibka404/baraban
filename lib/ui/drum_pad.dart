import 'package:flutter/material.dart';

import '../sound/dsp/dsp_api.dart';

class DrumPad extends StatefulWidget {
  final int paramId;
  final Size size;
  final ColorSwatch color;
  DrumPad(this.paramId, this.size, this.color);
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<DrumPad> {
  bool _gate = false;
  _State();

  void onTapDown(TapDownDetails event) {
    setState(() {
      _gate = true;
    });
    DspApi.setParamValue(widget.paramId, 1);
  }

  void onTapUp(TapUpDetails event) {
    setState(() {
      _gate = false;
    });
    DspApi.setParamValue(widget.paramId, 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        decoration:
            BoxDecoration(color: widget.color.withOpacity(_gate ? 0.8 : 1)),
      ),
      onTapDown: onTapDown,
      onTapUp: onTapUp,
    );
  }
}
