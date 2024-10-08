import 'package:brasil_fields/brasil_fields.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milkcontrolapp/components/datepicker_component.dart';
import 'package:milkcontrolapp/models/custos_mensais.dart';
import '../components/textfield_component.dart';
import '../components/title_component.dart';
import '../models/producao_mensal.dart';

class CadastroProducao extends StatefulWidget {
  const CadastroProducao({super.key});

  @override
  State<CadastroProducao> createState() =>
      _CadastroProducaoState();
}

class _CadastroProducaoState extends State<CadastroProducao> {

  TextEditingController litrosProduzidosController = TextEditingController();
  TextEditingController valorPorLitroController = TextEditingController();
  TextEditingController datasController = TextEditingController();

  List<DateTime> _selectedDates = [];

  void cadastrarProducaoMensal() {
    int litrosProduzidos = int.tryParse(litrosProduzidosController.text) ?? 0;
    double valorLitro = converterStringParaDouble(valorPorLitroController.text);

    ProducaoMensal producaoMensal = ProducaoMensal(
      periodo: _selectedDates,
      litrosProduzidos: litrosProduzidos,
      valorLitro: valorLitro,
    );

    print("Produção Mensal: ${producaoMensal.toMap()}");
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
              title: 'Cadastro de Produção Mensal',
              subtitle: 'Cadastre os itens produzidos no mês:',
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
            const SizedBox(height: 25.0),
            TextFieldComponent(
              hintText: 'Litros de leite produzidos',
              keyboardType: TextInputType.number,
              controller: litrosProduzidosController,
              prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),


            ),
            const SizedBox(height: 25.0),
            TextFieldComponent(
              hintText: 'Valor por Litro',
              keyboardType: TextInputType.number,
              controller: valorPorLitroController,
              prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter()

              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cadastrarProducaoMensal();

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
            // Container(
            //   padding: const EdgeInsets.only(left: 20, top: 30),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           SvgPicture.asset('assets/icons/exclamation-circle.svg'),
            //           SizedBox(width: 10.0),
            //           const Text(
            //             'Custos',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.w700,
            //                 fontSize: 14,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.only(left: 40, top: 15),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           const Text(
            //             'Cadastre os custos que teve em sua propriedade:',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 14,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // if (gastos.isEmpty)
            //   Container(
            //     padding: const EdgeInsets.only(
            //         top: 100, left: 20, right: 20, bottom: 40),
            //     child: Center(
            //       child: Column(
            //         children: [
            //           SvgPicture.asset(
            //             'assets/images/undraw_no_data_re_kwbl (1).svg',
            //             height: 100,
            //           ),
            //           SizedBox(
            //             height: 15,
            //           ),
            //           Text(
            //             'Nenhum item cadastrado, clique no botão para adicionar um item à lista de custos.',
            //             textAlign: TextAlign.center,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 25),
            //             child: ElevatedButton.icon(
            //               label: Text(
            //                 'Adicionar item',
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //               icon: Icon(
            //                 Icons.add,
            //                 color: Colors.white,
            //               ),
            //               onPressed: () {
            //                 _showItensDialog(context);
            //               },
            //               style: ElevatedButton.styleFrom(
            //                   backgroundColor: const Color(0xff194a7a),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(30),
            //                   )),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // if(gastos.isNotEmpty)
            //   Container(
            //     height: 200,
            //     child: ListView.builder(
            //       itemCount: gastos.length,
            //         itemBuilder: (BuildContext context, int index) {
            //       return Card(
            //         child: Column(
            //           children: [
            //             Text('Descrição: ${gastos[index].descricao}'),
            //             Text('Descrição: ${gastos[index].valor}'),
            //             Text('Descrição: ${gastos[index].quantidade}'),
            //           ],
            //         ),
            //       );
            //     }
            //     ),
            //   ),
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

    String cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    double value = double.parse(cleanText) / 100;

    final newText = _currencyFormat.format(value);

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

