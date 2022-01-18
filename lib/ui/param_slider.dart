import 'package:faust_flutter/sound/dsp/dsp_api.dart';
import 'package:flutter/material.dart';

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
        this._value = (getDspParam(paramId).min +
            (getDspParam(paramId).min + getDspParam(paramId).max) / 4),
        this._minValue = getDspParam(paramId).min,
        this._maxValue = getDspParam(paramId).max,
        this._label = getDspParam(paramId).label,
        this._unit = getDspParam(paramId).unit;

  int id;
  double _value;
  double _minValue;
  double _maxValue;
  String _label;
  String _unit;
  _setValue(double value) {
    setState(() {
      _value = value;
    });
    DspApi.setParamValue(id, value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$_label: ${_value.toStringAsPrecision(3)} $_unit"),
        Slider(
          value: _value,
          thumbColor: widget.color,
          activeColor: widget.color,
          onChanged: _setValue,
          min: _minValue,
          max: _maxValue,
          label: _label,
        ),
      ],
    );
  }
}
