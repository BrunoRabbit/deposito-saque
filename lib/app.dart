import 'package:deposit_withdraw/controllers/transaction_controller.dart';
import 'package:deposit_withdraw/pages/home_page/home_page.dart';
import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:deposit_withdraw/themes/colors_themes.dart';
import 'package:deposit_withdraw/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

application() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionController>(
      create: (_) => TransactionController(),
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldKey,
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.path,
        // themeMode: themeProvider.themeMode,
        theme: ColorsThemes.lightTheme,
        // darkTheme: MyTheme.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
