import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposit_withdraw/pages/home_page/widgets/history_card_widget.dart';
import 'package:deposit_withdraw/controllers/transaction_controller.dart';
import 'package:deposit_withdraw/models/transaction.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:deposit_withdraw/pages/home_page/widgets/area_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TransactionController transactionController;

  @override
  void didChangeDependencies() {
    transactionController =
        Provider.of<TransactionController>(context, listen: true);
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
              AppCustomText(
                label: UtilBrasilFields.obterReal(transactionController.value),
                size: 32,
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
              Row(
                children: [
                  const AppCustomText(
                    label: 'History transaction',
                    fontFamily: 'Roboto-Medium',
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              transactionController.listTransaction.isEmpty
                  ? const Spacer()
                  : Container(),
              transactionController.listTransaction.isEmpty
                  ? Center(
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
                    )
                  : Flexible(
                      child: ListView.builder(
                        itemCount: transactionController.listTransaction.length,
                        itemBuilder: (context, index) {
                          int reverseIndex =
                              transactionController.listTransaction.length -
                                  1 -
                                  index;
                          Transaction transaction = transactionController
                              .listTransaction[reverseIndex];

                          return HistoryCard(
                            transaction: transaction,
                          );
                        },
                      ),
                    ),
              transactionController.listTransaction.isEmpty
                  ? const Spacer()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
