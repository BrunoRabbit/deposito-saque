import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:deposit_withdraw/pages/form_pix_pay_page/widgets/modal_bottom_sheet_widget.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/current_balance/current_balance_bloc.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/history/history_bloc.dart';
import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:deposit_withdraw/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FormPixPayPage extends StatefulWidget {
  const FormPixPayPage({Key? key}) : super(key: key);

  @override
  State<FormPixPayPage> createState() => _FormPixPayPageState();
}

class _FormPixPayPageState extends State<FormPixPayPage> {
  late TextEditingController _formPixPayController;
  late CurrentBalanceBloc currentBalanceBloc;
  late HistoryBloc historyBloc;
  final DateFormat formatter = DateFormat('EEEE, HH:mm aaa, d/MMM yy');

  @override
  void didChangeDependencies() {
    currentBalanceBloc = BlocProvider.of<CurrentBalanceBloc>(context);
    historyBloc = BlocProvider.of<HistoryBloc>(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _formPixPayController = TextEditingController(
      text: UtilBrasilFields.obterReal(0, moeda: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(RoutesPath.kHomePage);
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              _openBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.info_outline_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: const AppCustomText(
          label: 'Pay',
          size: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<CurrentBalanceBloc, CurrentBalanceState>(
        bloc: currentBalanceBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  CircleAvatar(
                    radius: 45,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppCustomText(
                    label: 'Who are receive: Mauro',
                    fontWeight: FontWeight.w600,
                    color: Colors.black87.withOpacity(0.7),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            const AppCustomText(
                              label: 'You have: ',
                              fontWeight: FontWeight.normal,
                            ),
                            const Spacer(),
                            AppCustomText(
                              label: UtilBrasilFields.obterReal(
                                state.currentBalance,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: AppCustomText(
                            label: 'Amount to pay',
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Roboto-Regular',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(
                                moeda: true, casasDecimais: 2),
                          ],
                          controller: _formPixPayController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const AppCustomText(
                        label: 'Pay',
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        if (_formPixPayController.text.isNotEmpty) {
                          final _currentBalance =
                              UtilBrasilFields.converterMoedaParaDouble(
                            _formPixPayController.text,
                          );
                          if (_currentBalance > 0 &&
                              _currentBalance <= state.currentBalance) {
                            _onPay(_currentBalance);
                          } else {
                            failedSnackBar('Something went wrong', context);
                          }
                        } else {
                          failedSnackBar('The field cannot be empty', context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return const ModalBottomSheetWidget();
      },
    );
  }

  _onPay(double currentBalance) {
    currentBalanceBloc.add(
      ChangeBalanceValue(currentBalance: currentBalance * -1),
    );

    historyBloc.add(
      AddTransactionToHistory(
        transaction: Transaction(
          type: TransactionType.Transferred,
          dateTime: formatter.format(DateTime.now()),
          total: currentBalance,
        ),
      ),
    );
    sucessSnackBar('Successfully withdrawn', context);
    Navigator.of(context).pushReplacementNamed(RoutesPath.kHomePage);
  }
}
