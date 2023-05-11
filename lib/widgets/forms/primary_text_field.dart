import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool isInvalid;
  final String? errorText;
  final bool obscureText;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? textFormatters;

  const PrimaryTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.onChanged,
    this.keyboardType,
    this.errorText,
    this.isInvalid = false,
    this.obscureText = false,
    this.textFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isInvalid
                ? Border.all(
                    color: Colors.red,
                  )
                : null,
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            inputFormatters: textFormatters,
            decoration: InputDecoration(
              labelText: labelText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: obscureText,
          ),
        ),
        if (isInvalid)
          Text(
            errorText ?? '',
            style: TextStyle(
              fontSize: 10,
              color: Colors.red,
            ),
          )
      ],
    );
  }
}
