import 'package:flutter/material.dart';
import 'drum_controls.dart';
import 'drum_pad.dart';

class Drum extends StatelessWidget {
  final List<int> _paramIds;
  final int _gateId;
  Drum(this._gateId, this._paramIds);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DrumPad(_gateId),
        DrumParamControls(_paramIds),
      ],
    );
  }
}
