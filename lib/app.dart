import 'package:deposito_saque/controllers/transaction_controller.dart';
import 'package:deposito_saque/routes/app_routes.dart';
import 'package:deposito_saque/themes/colors_themes.dart';
import 'package:deposito_saque/views/home_view/home_view.dart';
import 'package:deposito_saque/widgets/app_snack_bar.dart';
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
        title: 'Flutter Demo',
        routes: AppRoutes.path,
        // themeMode: themeProvider.themeMode,
        theme: ColorsThemes.lightTheme,
        // darkTheme: MyTheme.darkTheme,
        home: const HomeView(),
      ),
    );
  }
}
