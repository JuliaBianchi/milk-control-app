import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import 'package:milkcontrolapp/models/animal.dart';
import 'package:milkcontrolapp/services/animais_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/title_component.dart';

class AnimalRegistration extends StatefulWidget {
  const AnimalRegistration({super.key});

  @override
  State<AnimalRegistration> createState() => _AnimalRegistrationState();
}

class _AnimalRegistrationState extends State<AnimalRegistration> {
  TextEditingController nomeAnimalController = TextEditingController();
  TextEditingController identificacaoAnimalController = TextEditingController();
  TextEditingController racaAnimalController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: '1', child: Text("Em lactação")),
      const DropdownMenuItem(value: '2', child: Text("Seca")),
      const DropdownMenuItem(value: '3', child: Text("Novilha")),
      const DropdownMenuItem(value: '4', child: Text("Boi")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsIdade {

    List<DropdownMenuItem<String>> menuItems =  [
        const DropdownMenuItem(value: '1', child:  Text("De 0 à 3 meses")),
        const DropdownMenuItem(value: '2', child: Text("De 4 à 6 meses")),
        const DropdownMenuItem(value: '3', child: Text("De 7 meses à 1 ano")),
        const DropdownMenuItem(value: '4', child: Text("De 1 ano até 2 anos")),
        const DropdownMenuItem(value: '5', child: Text("Acima de 2 anos")),

      ];

    return menuItems;
  }

  String? selectedCategory;
  String? selectedGender;
  String? selectedFaixaEtaria;

  AnimaisService service = AnimaisService();

  void registerAnimal() {
    Animal newAnimal = Animal(
      nomeAnimalController.text,
      identificacaoAnimalController.text,
      racaAnimalController.text,
      selectedFaixaEtaria,
      selectedCategory,
      selectedGender,
    );

    service.adicionarAnimal(newAnimal);
    print(newAnimal);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              title: 'Cadastro de Animais',
              subtitle: 'Aqui você pode cadastrar os animais de \n sua propriedade.',
            ),
            Form(
              child: Column(
                children: [
                  TextFieldComponent(
                    hintText: 'Nome do animal',
                    keyboardType: TextInputType.name,
                    controller: nomeAnimalController,
                    prefixIcon: Image.asset('assets/icons/icons8-cow-24.png'),
                  ),
                  TextFieldComponent(
                    hintText: 'Identificação',
                    keyboardType: TextInputType.text,
                    controller: identificacaoAnimalController,
                    prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),
                  ),
                  TextFieldComponent(
                    hintText: 'Raça',
                    keyboardType: TextInputType.text,
                    controller: racaAnimalController,
                    prefixIcon: Image.asset('assets/icons/clipboard-document-list.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Selecione a faixa etária do animal:', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
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

                      Container(
                        width: 300,
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButton(
                          hint: const Text('Faixa Etária'),
                          value: selectedFaixaEtaria,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedFaixaEtaria = newValue!;
                            });
                          },
                          items: dropdownItemsIdade,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          underline: Container(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Selecione a categoria do animal:', style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
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

                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButton(
                          value: selectedCategory,
                          hint: const Text('Categoria'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                            });
                          },
                          items: dropdownItems,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          underline: Container(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            ToggleSwitch(
              minWidth: 150.0,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey.shade300,
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 2,
              labels: const ['Macho', 'Fêmea'],
              icons: const [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
              activeBgColors: [
                const [Colors.blue],
                [Colors.pink.shade400]
              ],
              onToggle: (index) {
                selectedGender = index.toString();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ElevatedButtonComponent(
                onPressed: () {
                  registerAnimal();
                },
                text: 'Cadastrar',
                width: 150,
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
