import 'package:deposito_saque/components/card_pix.dart';
import 'package:deposito_saque/components/form_receber.dart';
import 'package:deposito_saque/routes/app_routes.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

class PixView extends StatefulWidget {
  const PixView({Key? key}) : super(key: key);

  @override
  State<PixView> createState() => _PixViewState();
}

class _PixViewState extends State<PixView> {
  bool isReceberTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppCustomText(
          label: 'Pix',
          size: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardPix(
                suffix: Icons.keyboard_arrow_right_rounded,
                title: 'Pagar',
                icon: Icons.attach_money_rounded,
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesPath.kCameraView);
                },
              ),
              CardPix(
                suffix: isReceberTap
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_right_rounded,
                title: 'Receber',
                icon: Icons.qr_code,
                onTap: () {
                  setState(() {
                    isReceberTap = !isReceberTap;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              isReceberTap ? const FormReceber() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
