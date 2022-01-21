import 'dart:math';

import 'package:flutter/material.dart';

class LogSlider extends StatelessWidget {
  final double value;
  final Color? thumbColor;
  final Color? activeColor;
  final Function(double)? onChanged;
  final double min;
  final double max;
  final String? label;

  LogSlider({
    required this.value,
    this.thumbColor,
    this.activeColor,
    this.onChanged,
    this.min = 0.01,
    this.max = 1,
    this.label,
  });

  double _logToLinear(double logValue) {
    return pow(e, logValue).toDouble();
  }

  double get _logMin => log(min);
  double get _logMax => log(max);
  double get _logValue => log(value);

  _onChanged(double value) {
    onChanged!(_logToLinear(value));
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _logValue,
      thumbColor: thumbColor,
      activeColor: activeColor,
      onChanged: _onChanged,
      min: _logMin,
      max: _logMax,
      label: label,
    );
  }
}
