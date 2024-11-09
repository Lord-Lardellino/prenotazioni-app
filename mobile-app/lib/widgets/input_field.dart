import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatefulWidget {
  String hint = "";
  var textController = TextEditingController();

  InputField({super.key, required this.hint, required this.textController});

  @override
  State<StatefulWidget> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        child: TextFormField(
          decoration: InputDecoration(
              hintText: widget.hint,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: context.theme.primaryColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey))),
          controller: widget.textController,
        ));
  }
}
