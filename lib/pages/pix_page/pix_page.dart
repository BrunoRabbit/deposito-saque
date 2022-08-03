import 'package:deposito_saque/pages/pix_page/widgets/receive_form.dart';
import 'package:deposito_saque/views/pix_view/widgets/card_pix.dart';
import 'package:deposito_saque/routes/app_routes.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

class PixPage extends StatefulWidget {
  const PixPage({Key? key}) : super(key: key);

  @override
  State<PixPage> createState() => _PixPageState();
}

class _PixPageState extends State<PixPage> {
  bool isReceiveTap = false;

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
                title: 'Pay',
                icon: Icons.attach_money_rounded,
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesPath.kCameraPage);
                },
              ),
              CardPix(
                suffix: isReceiveTap
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_right_rounded,
                title: 'Receive',
                icon: Icons.qr_code,
                onTap: () {
                  setState(() {
                    isReceiveTap = !isReceiveTap;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              isReceiveTap ? const ReceiveForm() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
