import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import 'package:milkcontrolapp/models/animal.dart';
import 'package:milkcontrolapp/pages/home_page.dart';
import 'package:milkcontrolapp/services/animais_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

import '../components/snackbar_component.dart';
import '../components/title_component.dart';
import '../provider/animais_provider.dart';

class AnimalRegistration extends StatefulWidget {
  final Animal? animal;

  const AnimalRegistration({super.key, this.animal});

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
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: '1', child: Text("De 0 à 3 meses")),
      const DropdownMenuItem(value: '2', child: Text("De 4 à 6 meses")),
      const DropdownMenuItem(value: '3', child: Text("De 7 meses à 1 ano")),
      const DropdownMenuItem(value: '4', child: Text("De 1 ano até 2 anos")),
      const DropdownMenuItem(value: '5', child: Text("Acima de 2 anos")),
    ];

    return menuItems;
  }

  Animal? animal;

  String? selectedCategory;
  String? selectedGender;
  String? selectedFaixaEtaria;

  bool isCadastroDesativado = false;
  bool showCheckbox = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void loadDataFields() {
    identificacaoAnimalController.text =
        widget.animal?.identificacao.toString() ?? '';
    nomeAnimalController.text = widget.animal?.nome ?? '';
    racaAnimalController.text = widget.animal?.raca ?? '';
    selectedFaixaEtaria = widget.animal?.faixaEtaria ?? selectedFaixaEtaria;
    selectedCategory = widget.animal?.categoria ?? selectedCategory;
    selectedGender = widget.animal?.genero ?? '0';
  }

  @override
  void initState() {
    loadDataFields();
    animal = widget.animal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animalProvider = Provider.of<AnimalProvider>(context);

    if (animal != null && animal?.ativado == true) {
      setState(() {
        showCheckbox = true;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
            identificacaoAnimalController.text.isEmpty
                ? const ContainerTitlePage(
                    title: 'Cadastro de Animais',
                    subtitle:
                        'Aqui você pode cadastrar os animais de \n sua propriedade.',
                  )
                : const ContainerTitlePage(
                    title: 'Editar Cadastro',
                    subtitle:
                        'Aqui você pode editar o cadastro feito do seu animal.',
                  ),
            Container(
              margin: const EdgeInsets.all(15),
              height: 160,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(
                  color: Colors.blue.shade700,
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/exclamation-circle.svg',
                          color: Colors.blue.shade700,
                          height: 25,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Atenção',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.blue.shade700),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    const Text(
                      '* Todos os campos devem ser preenchidos;',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10.0),
                    const Text(
                      '* O número de identificação deve ser único para cada animal.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              child: Column(
                children: [
                  TextFieldComponent(
                    hintText: 'Número de identificação',
                    keyboardType: TextInputType.text,
                    controller: identificacaoAnimalController,
                    prefixIcon:
                        Image.asset('assets/icons/clipboard-document-list.png'),
                  ),
                  TextFieldComponent(
                    hintText: 'Nome do animal',
                    keyboardType: TextInputType.name,
                    controller: nomeAnimalController,
                    prefixIcon: Image.asset('assets/icons/icons8-cow-24.png'),
                  ),
                  TextFieldComponent(
                    hintText: 'Raça',
                    keyboardType: TextInputType.text,
                    controller: racaAnimalController,
                    prefixIcon:
                        Image.asset('assets/icons/clipboard-document-list.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Faixa etária do animal:',
                        style: TextStyle(
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
                            fontSize: 16,
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
              margin:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Categoria do animal:',
                        style: TextStyle(
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
                            fontSize: 16,
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
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Gênero do animal:',
                        style: TextStyle(
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
                    children: [
                      ToggleSwitch(
                        minWidth: 150.0,
                        initialLabelIndex: int.tryParse(selectedGender!) ?? 0,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey.shade300,
                        inactiveFgColor: Colors.grey[900],
                        totalSwitches: 2,
                        labels: const ['Macho', 'Fêmea'],
                        fontSize: 16,
                        icons: const [
                          FontAwesomeIcons.mars,
                          FontAwesomeIcons.venus
                        ],
                        activeBgColors: [
                          const [Colors.blue],
                          [Colors.pink.shade400]
                        ],
                        onToggle: (index) {
                          selectedGender = index.toString();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: showCheckbox,
              child: CheckboxListTile(
                title: Text( 'Desativar cadastro'),
                value: isCadastroDesativado,
                onChanged: (bool? value) {
                  setState(() {
                    isCadastroDesativado = value ?? false;
                  print(isCadastroDesativado);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.blue.shade700,
              ),
            ),


              animalProvider.isLoading
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: SpinKitFadingCircle(color: Color(0xff1C6E8C)),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: ElevatedButtonComponent(
                      onPressed: () async {

                        if (animal?.identificacao == null) {

                          Animal animal = Animal(
                            uuid: const Uuid().v1(),
                            identificacao: int.tryParse(
                                identificacaoAnimalController.text),
                            nome: nomeAnimalController.text,
                            raca: racaAnimalController.text,
                            faixaEtaria: selectedFaixaEtaria,
                            categoria: selectedCategory,
                            genero: selectedGender,
                            ativado: true,
                          );

                          await animalProvider.addAnimals(animal);

                          if (animalProvider.errorMessage != null) {
                            showSnackBar(
                                context: context,
                                message: animalProvider.errorMessage!,
                                backgroundColor: Colors.red);
                          } else {
                            showSnackBar(
                                context: context,
                                message: 'Animal adicionado com sucesso!',
                                backgroundColor: Colors.green);

                            Navigator.push(
                              context,
                              PageTransition(
                                child: const HomePage(),
                                childCurrent: const AnimalRegistration(),
                                type: PageTransitionType.fade,
                              ),
                            );
                          }
                        } else {
                          Animal editanimal = Animal(
                            uuid: widget.animal?.uuid,
                            identificacao: int.tryParse(identificacaoAnimalController.text),
                            nome: nomeAnimalController.text,
                            raca: racaAnimalController.text,
                            faixaEtaria: selectedFaixaEtaria,
                            categoria: selectedCategory,
                            genero: selectedGender,
                            ativado: isCadastroDesativado ? false : true,
                          );

                          await animalProvider.editAnimal(editanimal);

                          if (animalProvider.errorMessage != null) {
                            showSnackBar(
                                context: context,
                                message: animalProvider.errorMessage!,
                                backgroundColor: Colors.red);
                          } else {
                            showSnackBar(
                                context: context,
                                message: 'Animal editado com sucesso!',
                                backgroundColor: Colors.green);

                            Navigator.push(
                              context,
                              PageTransition(
                                child: const HomePage(),
                                childCurrent: const AnimalRegistration(),
                                type: PageTransitionType.fade,
                              ),
                            );
                          }
                        }
                      },
                      text: animal == null
                          ? 'Cadastrar'
                          : 'Editar',
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
