import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedButton extends StatefulWidget {
  VoidCallback onPressed;
  String title;

  RoundedButton({super.key, required this.onPressed, required this.title});

  @override
  State<StatefulWidget> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: context.theme.primaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: context.theme.primaryColor,
                    spreadRadius: 1)
              ]),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18),
          ),
        ));
  }
}
