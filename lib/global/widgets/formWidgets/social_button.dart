import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final Function()? onTap;
  const SocialButton({
    Key? key,
    this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      child: Icon(
        icon,
        color: color,
      ),
      shape: CircleBorder(),
      elevation: 0.8,
      fillColor: Colors.grey.shade50,
      padding: const EdgeInsets.all(15.0),
    );
  }
}
