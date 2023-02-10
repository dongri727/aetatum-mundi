import 'package:flutter/material.dart';

class TffFormat extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Color tffColor1;
  final Color tffColor2;

  const TffFormat({
    required this.hintText,
    required this.onChanged,
    required this.tffColor1,
    required this.tffColor2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            color: tffColor1),
        fillColor: tffColor2,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: tffColor2,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: tffColor2,
            width: 1.0,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}


class ConfirmText extends StatelessWidget {
  final String confirmText;
  final Color confirmColor;

  const ConfirmText({
    required this.confirmText,
    required this.confirmColor,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: confirmColor),
      ),
      child: Center(
        child: Text(
          confirmText,
          style: TextStyle(
            fontSize: 20,
            color: confirmColor,
          ),
        ),
      ),
    );
  }
}