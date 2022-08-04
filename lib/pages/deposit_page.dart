// ignore_for_file: unnecessary_null_comparison

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

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  late CurrentBalanceBloc currentBalanceBloc;
  late final TextEditingController _depositController;
  final DateFormat formatter = DateFormat('EEEE, HH:mm aaa, d/MMM yy');

  @override
  void didChangeDependencies() {
    currentBalanceBloc = BlocProvider.of<CurrentBalanceBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _depositController = TextEditingController(
        text: UtilBrasilFields.obterReal(
      0,
      moeda: true,
    ));
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _depositController.dispose();
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
                text: 'How much ',
                style: TextStyle(
                  fontFamily: 'Roboto-SemiBold',
                  fontSize: 26,
                  color: const Color(0xff0000ff).withOpacity(0.75),
                  // fontWeight: FontWeight.w700,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: 'do \nyou want to ',
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'deposit',
                  ),
                  TextSpan(
                    text: '?',
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
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
                  controller: _depositController,
                  keyboardType: TextInputType.number,
                  maxLength: 13,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto-Regular',
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
              label: 'Enter an amount between \nR\$ 3,00 and R\$ 250,000.00',
              color: Colors.black.withOpacity(0.7),
              size: 16,
            ),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<CurrentBalanceBloc, CurrentBalanceState>(
              bloc: currentBalanceBloc,
              builder: (context, state) {
                return SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const AppCustomText(
                      label: 'Deposit',
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
                      final _currentBalance =
                          UtilBrasilFields.converterMoedaParaDouble(
                        _depositController.text,
                      );
                      if (_depositController.text.isNotEmpty &&
                          _currentBalance >= 3 &&
                          _currentBalance <= 250000) {
                        _onDeposit(_currentBalance);
                      } else {
                        failedSnackBar('Something went wrong', context);
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _onDeposit(double currentBalance) {
    currentBalanceBloc.add(
      ChangeBalanceValue(currentBalance: currentBalance),
    );
    context.read<HistoryBloc>().add(
          AddTransactionToHistory(
            transaction: Transaction(
              type: TransactionType.Deposit,
              dateTime: formatter.format(DateTime.now()),
              total: currentBalance,
            ),
          ),
        );
    sucessSnackBar('Successfully deposited', context);
    Navigator.of(context).pop();
  }
}
