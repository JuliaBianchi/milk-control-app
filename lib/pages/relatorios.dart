import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milkcontrolapp/components/datepicker_component.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import '../components/title_component.dart';

class RelatoriosPage extends StatefulWidget {
  const RelatoriosPage({super.key});

  @override
  State<RelatoriosPage> createState() =>
      _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  TextEditingController dateInputController = TextEditingController();


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: 'Relatórios',
              subtitle: 'Gerar os relatórios de produção e custos:',
            ),
            DatePickerComponent(
                dateInputController: dateInputController,
                initialDate: DateTime.now()
            ),
            const SizedBox(height: 25.0),
            ElevatedButtonComponent(
                onPressed: (){},
              text: 'Gerar',
              width: 150,
              color: const Color(0xff194a7a),
              colorText: Colors.white,

            ),


          ],
        ),
      ),
    );
  }
}
