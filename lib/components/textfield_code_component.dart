import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCodeComponent extends StatelessWidget {
  final String? initialValue;
  final Icon? icon;
  final bool readOnly;
  final TextEditingController? controller;
  final String? labelText;
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

  const TextFieldCodeComponent({
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
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: 50,
      height: 68,
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        controller: controller,
        cursorColor: const Color(0xff001F3D),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Color(0xFF656563),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
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
        ),
        keyboardType: keyboardType,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        onTap: onTap,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Esse campo não pode ser vazio.';
          }
          return null;
        },
        onChanged: onChanged,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
