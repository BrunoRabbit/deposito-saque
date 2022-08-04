import 'package:deposit_withdraw/pages/pix_page/cubit/open_card_cubit.dart';
import 'package:deposit_withdraw/pages/pix_page/widgets/card_pix_widget.dart';
import 'package:deposit_withdraw/pages/pix_page/widgets/receive_form.dart';
import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PixPage extends StatefulWidget {
  const PixPage({Key? key}) : super(key: key);

  @override
  State<PixPage> createState() => _PixPageState();
}

class _PixPageState extends State<PixPage> {
  late OpenCardCubit openCardCubit;
  @override
  void didChangeDependencies() {
    openCardCubit = BlocProvider.of<OpenCardCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppCustomText(
          label: 'Pix',
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
      body: BlocBuilder<OpenCardCubit, OpenCardState>(
        bloc: openCardCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CardPix(
                    suffix: Icons.keyboard_arrow_right_rounded,
                    title: 'Pay',
                    icon: Icons.attach_money_rounded,
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutesPath.kCameraPage);
                    },
                  ),
                  CardPix(
                    suffix: state.isOpen
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right_rounded,
                    title: 'Receive',
                    icon: Icons.qr_code,
                    onTap: () {
                      openCardCubit.isFormOpen(!state.isOpen);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  state.isOpen ? const ReceiveForm() : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
