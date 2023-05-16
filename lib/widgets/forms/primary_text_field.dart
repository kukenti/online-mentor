import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final String? hintText;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;
  final TextInputType? keyboardType;
  final double height;
  final double? minHeight;
  final Border? border;
  final Color backgroundColor;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool disabled;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final num? numLimit;
  final List<Widget> actions;
  final FocusNode? focusNode;
  final TextStyle? labelStyleOnDisabled;
  final BoxShadow? shadow;
  final InputDecoration decoration;
  final bool hide;
  final String? errorText;
  final bool hasError;
  final TextInputAction textInputAction;

  const PrimaryTextField({
    Key? key,
    this.controller,
    this.title,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.onTap,
    this.height = 58,
    this.minHeight,
    this.border,
    this.backgroundColor = Colors.white,
    this.disabled = false,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.obscureText = false,
    this.numLimit,
    this.actions = const <Widget>[],
    this.focusNode,
    this.labelStyleOnDisabled,
    this.shadow,
    this.keyboardType,
    this.decoration = const InputDecoration(),
    this.hintText,
    this.labelText,
    this.inputFormatters,
    this.onSubmitted,
    this.hide = false,
    this.errorText,
    this.hasError = false,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(widget.title!),
          ),
        Container(
          width: double.infinity,
          height: widget.minHeight == null ? widget.height : null,
          constraints: widget.minHeight != null
              ? BoxConstraints(
                  minHeight: widget.minHeight!,
                )
              : null,
          decoration: BoxDecoration(
            border: widget.hasError
                ? Border.all(color: Colors.red)
                : widget.border ?? Border.all(color: Color(0xFFE5E9EC)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: widget.backgroundColor,
            boxShadow: const [],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Center(
              child: TextField(
                enabled: !widget.disabled,
                maxLength: widget.maxLength,
                controller: widget.controller,
                readOnly: widget.readOnly,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                textInputAction: widget.textInputAction,
                autofocus: widget.autofocus,
                onTap: widget.onTap,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF353333),
                ),
                textAlign: TextAlign.start,
                decoration: widget.decoration.copyWith(
                    counterText: '',
                    isDense: true,
                    fillColor: Colors.transparent,
                    hintText: widget.hintText,
                    border: widget.decoration.border ?? InputBorder.none,
                    focusedBorder:
                        widget.decoration.focusedBorder ?? InputBorder.none,
                    contentPadding: widget.decoration.contentPadding ??
                        const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                    // errorText: widget.errorText,
                    errorStyle: const TextStyle(color: Colors.transparent),
                    errorBorder:
                        widget.decoration.errorBorder ?? InputBorder.none,
                    focusedErrorBorder: widget.decoration.focusedErrorBorder ??
                        InputBorder.none,
                    disabledBorder:
                        widget.decoration.disabledBorder ?? InputBorder.none,
                    enabledBorder:
                        widget.decoration.enabledBorder ?? InputBorder.none,
                    labelText: widget.labelText,
                    helperText: null,
                    labelStyle: widget.hasError
                        ? TextStyle(color: Colors.red)
                        : widget.labelStyleOnDisabled ??
                            const TextStyle(fontWeight: FontWeight.w500),
                    suffixIcon: widget.decoration.suffixIcon),
                inputFormatters: widget.inputFormatters,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
              ),
            ),
          ),
        ),
        if (widget.hasError)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              widget.errorText ?? '',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
