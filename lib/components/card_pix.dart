import 'package:flutter/material.dart';

import 'package:deposito_saque/widgets/app_custom_text.dart';

class CardPix extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final IconData suffix;

  const CardPix({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            leading: Container(
              height: 50,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
            title: Row(
              children: [
                AppCustomText(
                  label: title,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                Icon(
                  suffix,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
