import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/utility/colors.dart';

class BoxDialog extends StatefulWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  BoxDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<BoxDialog> createState() => _BoxDialogState();
}

class _BoxDialogState extends State<BoxDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: primaryColor,
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: whiteText),
                      hintText: "Add new task",
                      border: OutlineInputBorder()),
                ),
                //
                //
                const SizedBox(height: 20),
                //
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _dialogButton(text: "Cancel", onTap: widget.onCancel),
                    _dialogButton(text: "Add", onTap: widget.onSave),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _dialogButton extends StatelessWidget {
  final onTap;
  String? text;
  _dialogButton({super.key, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2.5),
            blurRadius: 10,
          )
        ], color: yellowButton, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Text(
          text!,
          style: const TextStyle(color: darkText),
        ),
      ),
    );
  }
}
