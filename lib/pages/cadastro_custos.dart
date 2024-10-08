import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../components/textfield_component.dart';
import '../components/title_component.dart';
import '../models/custos_mensais.dart';

class CadastroCustos extends StatefulWidget {
  const CadastroCustos({super.key});

  @override
  State<CadastroCustos> createState() =>
      _CadastroCustosState();
}

class _CadastroCustosState extends State<CadastroCustos> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorCustoController = TextEditingController();
  TextEditingController datasController = TextEditingController();

  List<DateTime> _selectedDates = [];

  void cadastrarCustos() {
    String descricao = descricaoController.text;
    double valorGasto = converterStringParaDouble(valorCustoController.text);
    print(valorCustoController.text);
    print(valorGasto);

    CustosMensais custos = CustosMensais(
      periodo: _selectedDates,
      descricao: descricao,
      valor: valorGasto,
    );

    print(custos.toString());
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
              color: Color(0xff194a7a),
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
              title: 'Cadastro de Custos Mensais',
              subtitle: 'Cadastre os custos de sua propriedade:',
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
                                'Selecione o período',
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

            const SizedBox(height: 15.0),
            TextFieldComponent(
              hintText: 'Descrição',
              keyboardType: TextInputType.text,
              controller: descricaoController,
              prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),


            ),
            const SizedBox(height: 25.0),
            TextFieldComponent(
              hintText: 'Valor',
              keyboardType: TextInputType.number,
              controller: valorCustoController,
              prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter()

              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cadastrarCustos();

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: const Text(
                    'Cadastrar',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: const Text(
                    'Cancelar',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class RealInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue(text: '');
    }

    // Remove tudo que não seja dígito
    String cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Converta para double e formate como moeda
    double value = double.parse(cleanText) / 100;

    final newText = _currencyFormat.format(value);

    // Retorne o novo valor formatado
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

double converterStringParaDouble(String valorString) {
  // Remover o símbolo da moeda e espaços
  String valorLimpo = valorString.replaceAll(RegExp(r'[R\$ ]'), '').replaceAll('.', '').replaceAll(',', '.');

  // Converter a string limpa para double
  return double.tryParse(valorLimpo) ?? 0.0; // Retorna 0.0 se a conversão falhar
}
