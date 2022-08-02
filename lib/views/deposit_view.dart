// ignore_for_file: unnecessary_null_comparison

import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:deposito_saque/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DepositView extends StatefulWidget {
  const DepositView({Key? key}) : super(key: key);

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  late final TextEditingController _moneyController;
  late TransactionController transactionController;

  @override
  void initState() {
    _moneyController = TextEditingController(
        text: UtilBrasilFields.obterReal(
      0,
      moeda: true,
    ));
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      transactionController =
          Provider.of<TransactionController>(context, listen: false);
    });
  }

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Quanto ',
                style: GoogleFonts.roboto(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0000ff).withOpacity(0.75),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'você \nquer ',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: 'depositar',
                  ),
                  TextSpan(
                    text: '?',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: _moneyController,
                  keyboardType: TextInputType.number,
                  maxLength: 13,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.4,
                      ),
                    ),
                    counterText: '',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(moeda: true, casasDecimais: 2),
                  ],
                ),
              ),
            ),
            const Spacer(),
            AppCustomText(
              label: 'Digite um valor entre R\$ 3,00 e R\$ 250.000,00',
              color: Colors.black.withOpacity(0.7),
              size: 16,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                child: const AppCustomText(
                  label: 'Depositar',
                  color: Colors.white,
                  size: 18,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: const Color(0xff282828),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () {
                  transactionController.verifyValueDeposit(
                    _moneyController.text,
                    context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
