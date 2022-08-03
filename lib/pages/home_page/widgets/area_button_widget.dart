import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:deposit_withdraw/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AreaButton extends StatelessWidget {
  const AreaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesPath.kPixPage);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.25),
                    child: Icon(
                      FontAwesomeIcons.pix,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const AppCustomText(
                  label: 'Pix',
                  size: 16,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesPath.kDepositPage);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.25),
                    child: Icon(
                      FontAwesomeIcons.circleDollarToSlot,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                AppCustomText(
                  label: 'Deposit',
                  size: 16,
                  color: Colors.black.withOpacity(0.8),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesPath.kWithdrawPage);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.25),
                    child: Icon(
                      FontAwesomeIcons.handHoldingDollar,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                AppCustomText(
                  label: 'Withdraw',
                  size: 16,
                  color: Colors.black.withOpacity(0.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
