import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposito_saque/controllers/transaction_controller.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormReceber extends StatefulWidget {
  const FormReceber({Key? key}) : super(key: key);

  @override
  State<FormReceber> createState() => _FormReceberState();
}

class _FormReceberState extends State<FormReceber> {
  late TextEditingController _emailController;
  late TextEditingController _moneyTransferController;
  late TransactionController transactionController;
  RegExp regexEmail = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+$");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _moneyTransferController = TextEditingController(
        text: UtilBrasilFields.obterReal(
      0,
      moeda: true,
    ));
    _emailController = TextEditingController();
    transactionController =
        Provider.of<TransactionController>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _moneyTransferController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: AppCustomText(
              label: 'Email',
              fontWeight: FontWeight.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
              validator: (text) {
                if (regexEmail.hasMatch(text!) && text.isEmpty) {
                  return 'Email não pode ser vazio!';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: AppCustomText(
              label: 'Dinheiro a receber',
              fontWeight: FontWeight.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: true, casasDecimais: 2),
              ],
              controller: _moneyTransferController,
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Dinheiro nao pode ser vazio';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              child: const AppCustomText(
                label: 'Receber dinheiro',
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
                if (_formKey.currentState!.validate()) {
                  transactionController.convertAndTransfer(
                    _moneyTransferController.text,
                    context,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
