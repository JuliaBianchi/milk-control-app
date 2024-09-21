import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldSearch extends StatelessWidget {

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const TextFormFieldSearch({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Pesquisar',
            labelStyle: TextStyle(
              color: Colors.grey.shade700,
            ),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.grey.shade700,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
          onTapOutside: (event) =>FocusScope.of(context).unfocus(),
        ),
      ),
    );
  }
}