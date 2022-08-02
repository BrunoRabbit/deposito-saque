import 'package:brasil_fields/brasil_fields.dart';
import 'package:deposito_saque/views/home_view/widgets/card_historico.dart';
import 'package:deposito_saque/controllers/transaction_controller.dart';
import 'package:deposito_saque/models/transaction.dart';
import 'package:deposito_saque/widgets/app_custom_text.dart';
import 'package:deposito_saque/views/home_view/widgets/area_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                label: 'Olá, Bruno',
                fontWeight: FontWeight.w400,
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
                label: 'Meu saldo atual',
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
                  Text(
                    'Histórico de transações',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
                            label: 'Nenhuma transação encontrada!',
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

                          return CardHistorico(
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
