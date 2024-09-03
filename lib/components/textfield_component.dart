import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatelessWidget {
  final String? initialValue;
  final Icon? icon;
  final bool readOnly;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final TapRegionCallback? onTapOutside;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? filled;
  final Color? fillColor;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final Function(String)? onFieldSubmitted;

  const TextFieldComponent({
    super.key,
    this.initialValue,
    this.icon,
    this.readOnly = false,
    this.controller,
    this.labelText,
    this.keyboardType,
    this.onChanged,
    this.onTapOutside,
    this.onSaved,
    this.validator,
    this.textInputAction,
    this.inputFormatters,
    this.filled = false,
    this.fillColor,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onTap,
    this.onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Card(
        elevation: 0,
        // color: Colors.transparent,
        child: TextFormField(
          initialValue: initialValue,
          readOnly: readOnly,
          controller: controller,
          cursorColor: const Color(0xff001F3D),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle:  TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              errorStyle: const TextStyle(fontSize: 12.0),
              errorMaxLines: 1,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xfff34141), width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xfff34141), width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: prefixIcon,
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white),
          obscureText: obscureText,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: textInputAction,
          onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
          onTap: onTap,
          validator: validator,
          inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
