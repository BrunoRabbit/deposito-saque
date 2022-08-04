import 'package:deposit_withdraw/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetWidget extends StatelessWidget {
  const ModalBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AppCustomText(
              label: 'Need help?',
              fontFamily: 'Roboto-Medium',
              size: 22,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Confirm the user information, and ',
                style: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 20,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'if the information ',
                  ),
                  TextSpan(
                    text: 'doesn\'t match',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff0000ff).withOpacity(0.75),
                    ),
                  ),
                  const TextSpan(text: ', '),
                  TextSpan(
                    text: 'check the qr code',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff0000ff).withOpacity(0.75),
                    ),
                  ),
                  const TextSpan(text: ', '),
                  const TextSpan(
                    text: 'you can go back at anytime in the upper left button',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
