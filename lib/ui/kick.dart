import 'package:flutter/material.dart';
import '../sound/dsp/dsp_param_ids.dart';
import 'param_slider.dart';
import 'drum_pad.dart';

class KickDrum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DrumPad(DspParamIds.kick_gate),
        DspParamSlider(DspParamIds.kick_pitch),
        DspParamSlider(DspParamIds.kick_click),
        DspParamSlider(DspParamIds.kick_attack),
        DspParamSlider(DspParamIds.kick_decay),
        DspParamSlider(DspParamIds.kick_drive),
      ],
    );
  }
}
