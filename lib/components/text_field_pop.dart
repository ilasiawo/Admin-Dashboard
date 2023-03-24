import 'package:flutter/material.dart';

class TextFieldPop extends StatelessWidget {
  const TextFieldPop(
      {super.key,
      required this.title,
      required this.value,
      required this.controller});
  final String title, value;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              // border: UnderlineInputBorder(),
              labelText: title,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            )),
      ),
    );
  }
}
