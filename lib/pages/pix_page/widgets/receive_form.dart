import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/current_balance/current_balance_bloc.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/history/history_bloc.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:deposit_withdraw/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReceiveForm extends StatefulWidget {
  const ReceiveForm({Key? key}) : super(key: key);

  @override
  State<ReceiveForm> createState() => _ReceiveFormState();
}

class _ReceiveFormState extends State<ReceiveForm> {
  late TextEditingController _emailController;
  late TextEditingController _moneyTransferController;
  late CurrentBalanceBloc currentBalanceBloc;
  RegExp regexEmail = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+$");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('EEEE, HH:mm aaa, d/MMM yy');

  @override
  void didChangeDependencies() {
    currentBalanceBloc = BlocProvider.of<CurrentBalanceBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _moneyTransferController = TextEditingController(
        text: UtilBrasilFields.obterReal(
      0,
      moeda: true,
    ));
    _emailController = TextEditingController();

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
              label: 'E-mail',
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
                  return 'E-mail cannot be empty!';
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
              label: 'Money to receive',
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
                  return 'Money cannot be empty';
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
                label: 'Receive money',
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
                  final _currentBalance =
                      UtilBrasilFields.converterMoedaParaDouble(
                    _moneyTransferController.text,
                  );
                  if (_moneyTransferController.text.isNotEmpty &&
                      _currentBalance > 0 &&
                      _currentBalance <= 250000) {
                    _onTransfer(_currentBalance);
                  } else {
                    failedSnackBar('Something went wrong', context);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _onTransfer(double currentBalance) {
    currentBalanceBloc.add(
      ChangeBalanceValue(currentBalance: currentBalance),
    );
    context.read<HistoryBloc>().add(
          AddTransactionToHistory(
            transaction: Transaction(
              type: TransactionType.Transferred,
              dateTime: formatter.format(DateTime.now()),
              total: currentBalance,
            ),
          ),
        );
    sucessSnackBar('Successfully transferred', context);
    Navigator.of(context).pop();
  }
}
