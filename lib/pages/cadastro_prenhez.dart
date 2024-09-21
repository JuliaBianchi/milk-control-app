import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/datepicker_component.dart';
import '../components/elevatedbutton_component.dart';
import '../components/title_component.dart';
import '../models/animal.dart';
import '../models/prenhez.dart';

class CadastroPrenhez extends StatefulWidget {
  const CadastroPrenhez({super.key});

  @override
  State<CadastroPrenhez> createState() => _CadastroPrenhezState();
}

class _CadastroPrenhezState extends State<CadastroPrenhez> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController obsController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: '1', child: Text("Em lactação")),
      const DropdownMenuItem(value: '2', child: Text("Seca")),
      const DropdownMenuItem(value: '3', child: Text("Novilha")),
      const DropdownMenuItem(value: '4', child: Text("Boi")),
    ];
    return menuItems;
  }

  List<Animal> animais = [
    Animal('Bobby', 'A123', 'Labrador', '3 anos', 'Cão', 'Macho'),
    Animal('Mimi', 'B456', 'Siamês', '2 anos', 'Gato', 'Fêmea'),
    Animal('Max', 'C789', 'Pastor Alemão', '4 anos', 'Cão', 'Macho'),
    Animal('Luna', 'D101', 'Poodle', '1 ano', 'Cão', 'Fêmea'),
    Animal('Bella', 'E112', 'Sphynx', '3 anos', 'Gato', 'Fêmea'),
  ];

  String? selectedAnimal;

  void cadastrarPrenhez() {

    Prenhez newPrenhez = Prenhez(
      animal: selectedAnimal,
      data: dateInputController.text,
      observacao: obsController.text,
    );

    print(newPrenhez);
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
              title: 'Cadastro de Prenhez',
              subtitle: 'Cadastro de prenhez do animal:',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
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
                            fontSize: 15),
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10.0),
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
                      borderSide:  BorderSide(color: Colors.red),
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
        
            DatePickerComponent(
              dateInputController: dateInputController,
              initialDate: DateTime.now(),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 40),
              child:
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/exclamation-circle.svg'),
                      SizedBox(width: 10.0),
                      const Text(
                        'Observações',
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
        
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ElevatedButtonComponent(
                onPressed: () {
                  cadastrarPrenhez();
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
