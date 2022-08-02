import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposito_saque/controllers/transaction_controller.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResgatarView extends StatefulWidget {
  const ResgatarView({Key? key}) : super(key: key);

  @override
  State<ResgatarView> createState() => _ResgatarViewState();
}

class _ResgatarViewState extends State<ResgatarView> {
  late TextEditingController _resgateController;
  late TransactionController transactionController;

  @override
  void initState() {
    _resgateController = TextEditingController(
        text: UtilBrasilFields.obterReal(
      0,
      moeda: true,
    ));
    transactionController =
        Provider.of<TransactionController>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _resgateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppCustomText(
          label: 'Resgatar',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const AppCustomText(
                      label: 'Saldo em conta',
                      fontWeight: FontWeight.normal,
                    ),
                    const Spacer(),
                    AppCustomText(
                      label: UtilBrasilFields.obterReal(
                          transactionController.value),
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const AppCustomText(
            label: 'Quanto você quer retirar do banco',
            fontWeight: FontWeight.normal,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: _resgateController,
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
          const SizedBox(
            height: 15,
          ),
          const Spacer(),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              child: const AppCustomText(
                label: 'Resgatar',
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
                transactionController.verifyValueResgate(
                  _resgateController.text,
                  context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
