import 'package:flutter/services.dart';
import 'package:qr_camera/qr_camera.dart';

extension CameraControllerExt on CameraController {
  Size? get size {
    final src = value.previewSize;
    if (src == null) return null;
    print('value.deviceOrientation: ${value.deviceOrientation}');
    if (isLandscape()) {
      return Size(src.width.toDouble(), src.height.toDouble());
    } else {
      return Size(src.height.toDouble(), src.width.toDouble());
    }
  }

  bool isLandscape() {
    return <DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ].contains(_getApplicableOrientation());
  }

  int getQuarterTurns() {
    final Map<DeviceOrientation, int> turns = <DeviceOrientation, int>{
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeRight: 1,
      DeviceOrientation.portraitDown: 2,
      DeviceOrientation.landscapeLeft: 3,
    };
    return turns[_getApplicableOrientation()]!;
  }

  DeviceOrientation _getApplicableOrientation() {
    return value.isRecordingVideo
        ? value.recordingOrientation!
        : (value.previewPauseOrientation ??
            value.lockedCaptureOrientation ??
            value.deviceOrientation);
  }
}
