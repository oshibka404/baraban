import 'dart:async';

import 'dsp/dsp_api.dart';
import 'dsp/dsp_param_ids.dart';

class KickDrum {
  double duration = 0.2;
  double pitch = 100;
  double click = 0.1;
  Timer? timer;

  void triggerKick() {
    var closeGate = () {
      timer = null;
      DspApi.setParamValue(DspParamIds.kick_gate, 0);
    };
    timer?.cancel();
    timer = Timer(Duration(milliseconds: (duration * 1000).toInt()), closeGate);
    DspApi.setParamValue(DspParamIds.kick_gate, 0).then((_) {
      DspApi.setParamValue(DspParamIds.kick_gate, 1);
    });
  }

  void setPitch(double pitch) {
    pitch = pitch;
    DspApi.setParamValue(DspParamIds.kick_pitch, pitch);
  }

  void setClick(double click) {
    click = click;
    DspApi.setParamValue(DspParamIds.kick_click, click);
  }

  void setDuration(double newDuration) {
    duration = newDuration;
  }
}
