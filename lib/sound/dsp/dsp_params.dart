import 'dsp_param_ids.dart';

const Map<int, DspParam> DspParams = {
  DspParamIds.kick_pitch: const DspParam(20, 200, "Pitch", "Hz"),
  DspParamIds.kick_click: const DspParam(0.005, 1, "Click", "sec"),
  DspParamIds.kick_attack: const DspParam(0.005, 0.4, "Attack", "sec"),
  DspParamIds.kick_decay: const DspParam(0.01, 4, "Decay", "sec"),
  DspParamIds.kick_drive: const DspParam(1, 10, "Drive", "X"),
};

var getDspParam = (int paramId) {
  return DspParams[paramId] ?? DspParam(0, 1, '???', '??');
};

class DspParam {
  const DspParam(this.min, this.max, this.label, this.unit);

  final double min;
  final double max;
  final String label;
  final String unit;
}
