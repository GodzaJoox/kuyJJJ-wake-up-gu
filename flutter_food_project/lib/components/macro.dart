import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData  icon;

  const MacroWidget({
    required this.title,
    required this.value,
    required this.icon,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow:  [
            BoxShadow(color: Colors.grey.shade400, 
            offset: const Offset(2, 2), 
            blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            FaIcon(
              icon,
            color: Colors.redAccent,),
            const SizedBox(height: 4,),
            Text(
              title == "Calories" 
              ? "$value $title"
              : "${value}g $title",
              style: const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    ));
  }
}


