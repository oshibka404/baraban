import 'package:faust_flutter/sound/dsp/dsp_params.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  _State();

  @override
  Widget build(BuildContext context) {
    return Consumer<DspParams>(
        builder: (context, params, child) => GestureDetector(
              child: Container(
                width: widget.size.width,
                height: widget.size.height,
                decoration: BoxDecoration(
                    color: widget.color.withOpacity(
                        params.getValue(widget.paramId) != 0 ? 0.8 : 1)),
              ),
              onTapDown: (event) => params.setValue(widget.paramId, 1),
              onTapUp: (event) => params.setValue(widget.paramId, 0),
              onTapCancel: () => params.setValue(widget.paramId, 0),
            ));
  }
}
