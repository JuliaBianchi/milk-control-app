import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';

class DatePickerComponent extends StatefulWidget {
  TextEditingController dateInputController;
  DateTime initialDate;

  DatePickerComponent({super.key, required this.dateInputController, required this.initialDate});

  @override
  State<DatePickerComponent> createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  late TextEditingController dateInputController;
  late DateTime initialDate;

  @override
  void initState() {
    super.initState();
    dateInputController = widget.dateInputController;
    initialDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFieldComponent(
        controller: dateInputController,
        hintText: 'Selecione a data',
        prefixIcon: Icon(CupertinoIcons.calendar),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            locale: const Locale('pt', 'BR'),
            initialDate: initialDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2080),
            confirmText: 'Cadastrar',
            cancelText: 'Cancelar',
            builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.blue),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade700,
                      backgroundColor: Colors.blue.shade100,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      alignment: Alignment.center),
                ),
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: Colors.white,
                  weekdayStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900
                  ),
                  dayStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black
                  ),
                  headerBackgroundColor: Colors.blue.shade100,
                  headerHeadlineStyle: const TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  dividerColor: Colors.transparent,
                ),
              ),
              child: child!,
            ),
          );
          if (pickedDate == null) return ;

          setState((){
            dateInputController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          });
        },
        validator: (value) {
          if (value == '') {
            return 'Por favor, selecione uma data.';
          }
          return null;
        },
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,

      ),
    );
  }
}