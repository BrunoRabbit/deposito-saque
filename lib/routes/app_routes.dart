import 'package:deposito_saque/pages/camera_page/camera_page.dart';
import 'package:deposito_saque/pages/deposit_page.dart';
import 'package:deposito_saque/pages/home_page/home_page.dart';
import 'package:deposito_saque/pages/pix_page/pix_page.dart';
import 'package:deposito_saque/pages/withdraw_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> path = {
    RoutesPath.kDepositPage: (_) => const DepositPage(),
    RoutesPath.kHomePage: (_) => const HomePage(),
    RoutesPath.kWithdrawPage: (_) => const WithdrawPage(),
    RoutesPath.kPixPage: (_) => const PixPage(),
    RoutesPath.kCameraPage: (_) => const CameraPage(),
  };
}

class RoutesPath {
  static const kDepositPage = '/deposit_page';
  static const kHomePage = '/home_page';
  static const kWithdrawPage = '/withdraw_page';
  static const kPixPage = '/pix_page';
  static const kCameraPage = '/camera_page';
}
