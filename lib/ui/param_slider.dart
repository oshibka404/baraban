import 'package:faust_flutter/sound/dsp/dsp_api.dart';
import 'package:faust_flutter/sound/dsp/dsp_param_ids.dart';
import 'package:flutter/material.dart';

class DspParamSlider extends StatefulWidget {
  final int paramId;
  DspParamSlider(this.paramId);
  @override
  _DspParamSliderState createState() => _DspParamSliderState(this.paramId);
}

class _DspParamSliderState extends State<DspParamSlider> {
  _DspParamSliderState(int paramId)
      : this.id = paramId,
        this._value = (getDspParamProperties(paramId).min +
            (getDspParamProperties(paramId).min +
                    getDspParamProperties(paramId).max) /
                4),
        this._minValue = getDspParamProperties(paramId).min,
        this._maxValue = getDspParamProperties(paramId).max,
        this._label = getDspParamProperties(paramId).label,
        this._unit = getDspParamProperties(paramId).unit;

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
          onChanged: _setValue,
          min: _minValue,
          max: _maxValue,
          label: _label,
        ),
      ],
    );
  }
}

const Map<int, DspParamProperties> DspParamPropertiesMap = {
  DspParamIds.kick_pitch: const DspParamProperties(20, 200, "Pitch", "Hz"),
  DspParamIds.kick_click: const DspParamProperties(0.005, 1, "Click", "sec"),
  DspParamIds.kick_attack:
      const DspParamProperties(0.005, 0.4, "Attack", "sec"),
  DspParamIds.kick_decay: const DspParamProperties(0.01, 4, "Decay", "sec"),
  DspParamIds.kick_drive: const DspParamProperties(1, 10, "Drive", "X"),
};

var getDspParamProperties = (int paramId) {
  return DspParamPropertiesMap[paramId] ??
      DspParamProperties(0, 1, '???', '??');
};

class DspParamProperties {
  const DspParamProperties(this.min, this.max, this.label, this.unit);

  final double min;
  final double max;
  final String label;
  final String unit;
}
