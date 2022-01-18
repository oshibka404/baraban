import 'package:flutter/material.dart';

import 'param_slider.dart';

class DrumParamControls extends StatelessWidget {
  final List<int> _paramIds;
  final ColorSwatch color;
  DrumParamControls(this._paramIds, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [..._paramIds.map((id) => DspParamSlider(id, color))],
    );
  }
}
