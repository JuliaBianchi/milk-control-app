import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milkcontrolapp/models/antibiotico.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../components/datepicker_component.dart';
import '../components/elevatedbutton_component.dart';
import '../components/textfield_component.dart';
import '../components/title_component.dart';

class CadastroAntibiotico extends StatefulWidget {
  const CadastroAntibiotico({super.key});

  @override
  State<CadastroAntibiotico> createState() => _CadastroAntibioticoState();
}

class _CadastroAntibioticoState extends State<CadastroAntibiotico> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController obsController = TextEditingController();
  TextEditingController diasCarenciaController = TextEditingController();
  TextEditingController nomeMedicacaoController = TextEditingController();

  String? selectedAnimal;
  int? selectedAplicacao;
  int? selectedTurno;

  cadastrarAntibiotico(){

    DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(dateInputController.text);

    Antibiotico antibiotico = Antibiotico(
      selectedAnimal,
      parsedDate,
      selectedAplicacao,
      nomeMedicacaoController.text,
      int.tryParse(diasCarenciaController.text),
      obsController.text,
      selectedTurno,
    );

    print(antibiotico);
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
              title: 'Cadastro de Antibiótico',
              subtitle: 'Cadastre o antibiótico aplicado no seu animal:',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownSearch<String>(
                items: (filter, infiniteScrollProps) =>
                ["Menu", "Dialog", "Modal", "BottomSheet"],
                onChanged: (String? newValue) {
                  setState(() {
                    print(newValue);
                    selectedAnimal = newValue;
                  });
                },
                selectedItem: selectedAnimal ,
                // itemAsString: (Animal animal) => '${animal.nome} - ${animal.identificacao}',
                popupProps: PopupProps.dialog(
                  emptyBuilder: (context, searchEny) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lista de animais vazia.',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  searchFieldProps: TextFieldProps(
                    // padding: EdgeInsets.all(10),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.grey.shade700,
                    ),
                  ),
                  showSearchBox: true,
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                      labelText: 'Selecione seu animal',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:  const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Image.asset('assets/icons/icons8-cow-24.png')
                  ),
                ),
                validator: (value) => value == null
                    ? 'Por favor, selecione um animal para continuar.'
                    : null,
              ),
            ),
            const SizedBox(height: 15,),
            DatePickerComponent(
              dateInputController: dateInputController,
              initialDate: DateTime.now(),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Aplicação realizada antes ou depois da ordenha:', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0XFF4F4F4F),
                      ),

                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        minWidth: 150.0,
                        initialLabelIndex: 0,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey.shade300,
                        inactiveFgColor: Colors.grey[900],
                        totalSwitches: 2,
                        fontSize: 16,
                        labels: const ['Antes', 'Depois'],
                        activeBgColors: const [
                          [Colors.blue],
                          [Colors.blue],
                        ],
                        onToggle: (index) {
                           selectedAplicacao = index;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Turno em que foi feita a aplicação:', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0XFF4F4F4F),
                      ),),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        minWidth: 150.0,
                        initialLabelIndex: 0,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey.shade300,
                        inactiveFgColor: Colors.grey[900],
                        totalSwitches: 2,
                        labels: const ['Manhã', 'Tarde'],
                        fontSize: 16,
                        activeBgColors: const [
                          [Colors.blue],
                          [Colors.blue],
                        ],
                        onToggle: (index) {
                          selectedTurno = index;
                        },
                      ),
                    ],
                  ),

                ],
              ),

            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldComponent(
              hintText: 'Nome da medicação',
              keyboardType: TextInputType.text,
              controller: nomeMedicacaoController,
              prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldComponent(
              hintText: 'Dias de carência',
              keyboardType: TextInputType.number,
              controller: diasCarenciaController,
              prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),
            ),
            Container(
              padding: const EdgeInsets.only(left: 40, top: 30),
              child:
              Row(
                children: [
                  SvgPicture.asset('assets/icons/exclamation-circle.svg'),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Observações',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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
                        hintText: 'Digite...',
                        hintStyle: TextStyle(color: Color(0xFF9EA5AD)),
                        border: InputBorder.none,
                        suffixIconConstraints:
                        BoxConstraints(maxWidth: 24, maxHeight: 24),
                        contentPadding: EdgeInsets.only( left: 8.0, right: 15.0, top: 15.0, bottom: 5.0),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 5,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
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
                  cadastrarAntibiotico();

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
