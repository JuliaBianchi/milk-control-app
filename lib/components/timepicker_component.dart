import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';

class TimePickedComponent extends StatefulWidget {
  TextEditingController timeInputController;
  TimeOfDay initialTime;

  TimePickedComponent({super.key, required this.timeInputController, required this.initialTime});

  @override
  State<TimePickedComponent> createState() => _TimePickedComponentState();
}

class _TimePickedComponentState extends State<TimePickedComponent> {
  late TextEditingController timeInputController;
  late TimeOfDay initialTime;

  @override
  void initState() {
    super.initState();
    timeInputController = widget.timeInputController;
    initialTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFieldComponent(
        controller: timeInputController,
        hintText: 'Selecione o horário',
        prefixIcon: Icon(CupertinoIcons.time),
        suffixIcon: Icon(Icons.arrow_drop_down_outlined),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        readOnly: true,
        onTap: () async {

         TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
              hourLabelText: 'Hora',
              minuteLabelText: 'Minuto',
           confirmText: 'Cadastrar',
           cancelText: 'Cancelar',
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
            );

         if (pickedTime == null) return ;

          setState((){
            String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
            timeInputController.text = formattedTime;
          });
        },
        validator: (value) {
          if (value == '') {
            return 'Por favor, selecione um horário.';
          }
          return null;
        },

        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,

      ),
    );
  }
}