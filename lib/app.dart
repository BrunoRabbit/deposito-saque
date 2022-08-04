import 'package:deposit_withdraw/pages/form_pix_pay_page/form_pix_pay_page.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/current_balance/current_balance_bloc.dart';
import 'package:deposit_withdraw/pages/home_page/blocs/history/history_bloc.dart';
import 'package:deposit_withdraw/pages/pix_page/cubit/open_card_cubit.dart';
import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:deposit_withdraw/themes/colors_themes.dart';
import 'package:deposit_withdraw/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

application() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late HistoryBloc historyBloc;
  late CurrentBalanceBloc currentBalanceBloc;
  late OpenCardCubit openCardCubit;

  @override
  void initState() {
    historyBloc = HistoryBloc();
    currentBalanceBloc = CurrentBalanceBloc();
    openCardCubit = OpenCardCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HistoryBloc>(
          create: (context) => historyBloc,
        ),
        BlocProvider<CurrentBalanceBloc>(
          create: (context) => currentBalanceBloc,
        ),
        BlocProvider<OpenCardCubit>(
          create: (context) => openCardCubit,
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldKey,
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.path,
        // themeMode: themeProvider.themeMode,
        theme: ColorsThemes.lightTheme,
        // darkTheme: MyTheme.darkTheme,
        home: const FormPixPayPage(), // HOMEPAGE
      ),
    );
  }
}
