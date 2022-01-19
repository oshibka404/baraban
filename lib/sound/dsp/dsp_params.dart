import 'dart:async';

import 'package:faust_flutter/sound/dsp/dsp_api.dart';
import 'package:flutter/foundation.dart';

import 'dsp_param_ids.dart';

Map<int, DspParam> dspParams = {
  DspParamIds.kick_pitch: DspParam("Pitch", "Hz"),
  DspParamIds.kick_click: DspParam("Click", "sec"),
  DspParamIds.kick_attack: DspParam("Attack", "sec"),
  DspParamIds.kick_decay: DspParam("Decay", "sec"),
  DspParamIds.kick_drive: DspParam("Drive", "X"),
};

var getDspParam = (int paramId) => dspParams[paramId] ?? DspParam('???', '??');

class DspParam {
  DspParam(this.label, this.unit);

  double min = 0;
  double max = 1;
  double initialValue = 0.25;
  double value = 0;
  final String label;
  final String unit;
}

var loadDspParams = () async {
  var paramsCount = await DspApi.getParamsCount() ?? 0;
  for (int id = 0; id < paramsCount; id++) {
    if (!dspParams.containsKey(id)) {
      dspParams[id] = DspParam("???", "??");
    }
    dspParams[id]!.initialValue = await DspApi.getParamInit(id) ?? 0;
    dspParams[id]!.min = await DspApi.getParamMin(id) ?? 0;
    dspParams[id]!.max = await DspApi.getParamMax(id) ?? 1;
  }
};

class DspParams extends ChangeNotifier {
  late Timer _timer;
  DspParams() {
    _timer = Timer.periodic(Duration(milliseconds: 20), (_) {
      if (hasListeners) {
        update();
      }
    });
  }

  dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<double> _values = [];

  double? getValue(int id) {
    if (_values.length > id) {
      return _values[id];
    }
    return null;
  }

  void setValue(int id, double value) {
    DspApi.setParamValue(id, value);
  }

  void update() async {
    var newValues = await DspApi.getAllParamValues();
    if (!listEquals(_values, newValues)) {
      _values = newValues;
      notifyListeners();
    }
  }
}
