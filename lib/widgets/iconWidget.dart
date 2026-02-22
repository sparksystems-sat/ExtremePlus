import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Color? color;
  final IconData icon;
  double? size;
  IconWidget(
      {Key? key, required this.icon, this.color = Colors.yellow, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
