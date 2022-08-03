import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/controllers/transaction_controller.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  late TextEditingController _withdrawController;
  late TransactionController transactionController;

  @override
  void initState() {
    _withdrawController = TextEditingController(
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
    _withdrawController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppCustomText(
          label: 'Withdraw',
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
                      label: 'Account balance',
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
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'How much ',
              style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0000ff).withOpacity(0.75)),
              children: const <TextSpan>[
                TextSpan(
                  text: 'do you want\n to ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'withdraw',
                ),
                TextSpan(
                  text: ' from the ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'bank',
                ),
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: _withdrawController,
                keyboardType: TextInputType.number,
                maxLength: 13,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: const TextStyle(
                  fontFamily: 'Roboto-Regular',
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
                label: 'Withdraw',
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
                  _withdrawController.text,
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
