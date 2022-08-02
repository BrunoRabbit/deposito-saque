import 'package:deposito_saque/views/camera_view.dart';
import 'package:deposito_saque/views/deposit_view.dart';
import 'package:deposito_saque/views/home_view/home_view.dart';
import 'package:deposito_saque/views/pix_view.dart';
import 'package:deposito_saque/views/resgatar_view.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> path = {
    RoutesPath.kDepositView: (_) => const DepositView(),
    RoutesPath.kHomeView: (_) => const HomeView(),
    RoutesPath.kResgatarView: (_) => const ResgatarView(),
    RoutesPath.kPixView: (_) => const PixView(),
    RoutesPath.kCameraView: (_) => const CameraView(),
  };
}

class RoutesPath {
  static const kDepositView = '/deposit-view';
  static const kHomeView = '/home-view';
  static const kResgatarView = '/resgatar-view';
  static const kPixView = '/pix-view';
  static const kCameraView = '/camera-view';
}
