import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milkcontrolapp/models/dieta.dart';

import '../components/elevatedbutton_component.dart';
import '../components/textfield_component.dart';
import '../components/title_component.dart';

class CadastroDieta extends StatefulWidget {
  const CadastroDieta({super.key});

  @override
  State<CadastroDieta> createState() => _CadastroDietaState();
}

class _CadastroDietaState extends State<CadastroDieta> {
  TextEditingController qtdAnimaisLactacao = TextEditingController();
  TextEditingController datasController = TextEditingController();
  TextEditingController obsController = TextEditingController();

  List<DateTime> _selectedDates = [];

  void cadastrarDieta() {

      Dieta dieta = Dieta(periodo: _selectedDates, qtdAnimaisLactacao: qtdAnimaisLactacao.text, obs: obsController.text);
      print(dieta);

  }


  @override
  void initState() {

    _selectedDates.add(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/Vector (2).png',
              height: 120,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              color: const Color(0xff194a7a),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
              ],
            ),
            const ContainerTitlePage(
              title: 'Cadastro de Dietas',
              subtitle: 'Cadastre a dieta do seu animal:',
            ),
            TextFieldComponent(
              hintText: 'Período',
              keyboardType: TextInputType.text,
              controller: datasController,
              prefixIcon:
                  Image.asset('assets/icons/clipboard-document-list.png'),
              onTap: () async {
                var selectedDates = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Selecione o ínicio e o fim',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),

                              CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.range,

                                  selectedDayHighlightColor: Colors.blue.shade700,

                                  controlsTextStyle: TextStyle(color: Colors.black, fontSize: 16),
                                  disabledDayTextStyle: TextStyle(color: Colors.grey),


                                ),

                                onValueChanged: (dates) {
                                  setState(() {
                                    _selectedDates = dates;

                                  });
                                },
                                value: _selectedDates,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      datasController.text = '${DateFormat('dd/MM/yyyy').format(_selectedDates.first)} até ${DateFormat('dd/MM/yyyy').format(_selectedDates.last)}';
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade100,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        )),
                                    child:  Text(
                                      'Adicionar',
                                      style:
                                      TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade100,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        )),
                                    child: Text(
                                      'Cancelar',
                                      style:
                                      TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

                if (selectedDates != null) {
                  setState(() {
                    _selectedDates = selectedDates;
                  });
                }
              },
            ),
            TextFieldComponent(
              hintText: 'Quantidade de animais em lactação',
              keyboardType: TextInputType.number,
              controller: qtdAnimaisLactacao,
              prefixIcon:
                  Image.asset('assets/icons/clipboard-document-list.png'),
            ),
            Container(
              padding: const EdgeInsets.only(left: 40, top: 30),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/exclamation-circle.svg'),
                  SizedBox(width: 10.0),
                  const Text(
                    'Informações da dieta:',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 320,
              height: 125,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 280,
                    height: 120,
                    color: Colors.white,
                    child: TextFormField(
                      controller: obsController,
                      decoration: const InputDecoration(
                        hintText:
                            'Ex: 2kg de silagem e mais 500gr de ração por animal.',
                        hintStyle: TextStyle(color: Color(0xFF9EA5AD)),
                        border: InputBorder.none,
                        suffixIconConstraints:
                            BoxConstraints(maxWidth: 24, maxHeight: 24),
                        contentPadding: EdgeInsets.only(
                            left: 8.0, right: 15.0, top: 15.0, bottom: 5.0),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 5,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF454C52),
                      ),
                      cursorColor: const Color(0xFF454C52),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child:
                          SvgPicture.asset('assets/icons/pencil-square.svg')),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ElevatedButtonComponent(
                onPressed: () {
                  cadastrarDieta();
                },
                text: 'Cadastrar',
                width: 250,
                color: const Color(0xff194a7a),
                colorText: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

