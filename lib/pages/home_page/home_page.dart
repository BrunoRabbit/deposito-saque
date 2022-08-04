import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/current_balance/current_balance_bloc.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/history/history_bloc.dart';
import 'package:deposit_withdraw/pages/home_page/widgets/history_card_widget.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:deposit_withdraw/pages/home_page/widgets/area_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HistoryBloc historyBloc;
  late Transaction transaction;
  late CurrentBalanceBloc currentBalanceBloc;

  @override
  void didChangeDependencies() {
    currentBalanceBloc = BlocProvider.of<CurrentBalanceBloc>(context);
    historyBloc = BlocProvider.of<HistoryBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 26, right: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppCustomText(
                label: 'Hi, Bruno',
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<CurrentBalanceBloc, CurrentBalanceState>(
                bloc: currentBalanceBloc,
                builder: (context, state) {
                  return AppCustomText(
                    label: UtilBrasilFields.obterReal(
                      state.currentBalance,
                    ),
                    size: 32,
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              AppCustomText(
                label: 'Current balance',
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                height: 25,
              ),
              const AreaButton(),
              const SizedBox(
                height: 25,
              ),
              const AppCustomText(
                label: 'History transaction',
                fontFamily: 'Roboto-Medium',
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<HistoryBloc, HistoryState>(
                bloc: historyBloc,
                builder: (context, state) {
                  if (state.historyTransaction.isEmpty) {
                    return Flexible(
                      child: Column(
                        children: [
                          const Spacer(),
                          Center(
                            child: Column(
                              children: [
                                const AppCustomText(
                                  label: 'No transactions found!',
                                  size: 20,
                                ),
                                Icon(
                                  Icons.search_off,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    );
                  }
                  return Flexible(
                    child: ListView.builder(
                      itemCount: state.historyTransaction.length,
                      itemBuilder: (context, index) {
                        int reverseIndex =
                            state.historyTransaction.length - 1 - index;
                        Transaction transaction =
                            state.historyTransaction[reverseIndex];

                        return HistoryCard(
                          transaction: transaction,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
