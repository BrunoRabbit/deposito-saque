import 'package:deposit_withdraw/pages/camera_page/camera_page.dart';
import 'package:deposit_withdraw/pages/deposit_page.dart';
import 'package:deposit_withdraw/pages/form_pix_pay_page/form_pix_pay_page.dart';
import 'package:deposit_withdraw/pages/home_page/home_page.dart';
import 'package:deposit_withdraw/pages/pix_page/pix_page.dart';
import 'package:deposit_withdraw/pages/withdraw_page/withdraw_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> path = {
    RoutesPath.kDepositPage: (_) => const DepositPage(),
    RoutesPath.kHomePage: (_) => const HomePage(),
    RoutesPath.kWithdrawPage: (_) => const WithdrawPage(),
    RoutesPath.kPixPage: (_) => const PixPage(),
    RoutesPath.kCameraPage: (_) => const CameraPage(),
    RoutesPath.kFormPixPay: (_) => const FormPixPayPage(),
  };
}

class RoutesPath {
  static const kDepositPage = '/deposit_page';
  static const kHomePage = '/home_page';
  static const kWithdrawPage = '/withdraw_page';
  static const kPixPage = '/pix_page';
  static const kCameraPage = '/camera_page';
  static const kFormPixPay = '/form_pix_pay_page';
}
