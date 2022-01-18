import 'package:flutter/material.dart';

import '../sound/dsp/dsp_params.dart';
import 'param_slider.dart';

class DrumParamControls extends StatelessWidget {
  final List<int> _paramIds;
  final ColorSwatch color;
  DrumParamControls(this._paramIds, this.color);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [..._paramIds.map((id) => DspParamSlider(id, color))],
          );
        }
        return Text("loading...");
      }),
      future: loadDspParams(),
    );
  }
}
