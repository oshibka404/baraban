import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sound/dsp/dsp_params.dart';

class DspParamSlider extends StatefulWidget {
  final int paramId;
  final ColorSwatch color;
  DspParamSlider(this.paramId, this.color);
  @override
  _DspParamSliderState createState() => _DspParamSliderState(this.paramId);
}

class _DspParamSliderState extends State<DspParamSlider> {
  _DspParamSliderState(int paramId)
      : this.id = paramId,
        this._minValue = getDspParam(paramId).min,
        this._maxValue = getDspParam(paramId).max,
        this._label = getDspParam(paramId).label,
        this._unit = getDspParam(paramId).unit;

  final int id;
  final double _minValue;
  final double _maxValue;
  final String _label;
  final String _unit;

  @override
  Widget build(BuildContext context) {
    return Consumer<DspParams>(
      builder: (context, dspParams, child) {
        double value = dspParams.getValue(id) ?? _minValue;

        return Column(
          children: [
            Text("$_label: ${value.toStringAsPrecision(3)} $_unit"),
            Slider(
              value: value,
              thumbColor: widget.color,
              activeColor: widget.color,
              onChanged: (value) => dspParams.setValue(id, value),
              min: _minValue,
              max: _maxValue,
              label: _label,
            ),
          ],
        );
      },
    );
  }
}
