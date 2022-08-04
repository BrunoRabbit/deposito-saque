import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:flutter/material.dart';

class FormPixPayPage extends StatelessWidget {
  const FormPixPayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RoutesPath.kHomePage);
            },
            child: const Icon(
              Icons.home,
            ),
          ),
        ],
        title: const Text(''),
      ),
      body: Container(), // TODO - receive money != 0
    );
  }
}
