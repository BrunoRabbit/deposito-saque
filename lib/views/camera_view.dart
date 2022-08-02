import 'package:deposito_saque/helpers/qr_overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late MobileScannerController cameraController;
  @override
  void initState() {
    cameraController = MobileScannerController(torchEnabled: true);

    cameraController.switchCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: ((barcode, args) {
              debugPrint('Bar code found!' + barcode.rawValue!);
            }),
          ),
          QrOverlay(
            overlayColor: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
