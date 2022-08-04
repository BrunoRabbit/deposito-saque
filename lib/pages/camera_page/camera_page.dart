import 'package:deposit_withdraw/pages/camera_page/widgets/qr_overlay_widget.dart';
import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:deposit_withdraw/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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
              Navigator.of(context).pushNamed(RoutesPath.kFormPixPay);
              sucessSnackBar('Successfully scanned', context);
              cameraController.stop();
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
