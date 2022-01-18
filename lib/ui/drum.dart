import 'package:flutter/material.dart';
import 'drum_controls.dart';
import 'drum_pad.dart';

class Drum extends StatelessWidget {
  final List<int> _paramIds;
  final int _gateId;
  final ColorSwatch color;
  Drum(this._gateId, this._paramIds, this.color);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var drumPadSize = isPortrait
        ? Size(screenSize.width, screenSize.height / 2)
        : Size(screenSize.width / 2, screenSize.height);
    return isPortrait
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrumPad(_gateId, drumPadSize, color),
              Expanded(child: DrumParamControls(_paramIds, color)),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrumPad(_gateId, drumPadSize, color),
              Expanded(child: DrumParamControls(_paramIds, color)),
            ],
          );
  }
}
