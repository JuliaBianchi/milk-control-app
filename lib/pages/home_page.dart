import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:milkcontrolapp/components/card_home_component.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/listtile_component.dart';
import 'package:milkcontrolapp/components/menu_drawer.dart';
import 'package:milkcontrolapp/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Color(0xff1C6E8C),
      appBar: AppBar(
        title: const Text(
          'Bem-vindo!',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
        ),
        toolbarHeight: 86,
        elevation: 0,
        backgroundColor: Color(0xff1C6E8C),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
            } else {
              scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.solidBell,
                color: Colors.white,
                size: 22,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 400,
                child: Card(
                  color: Color(0xff656563),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: deviceWidth < 600 ? 2 : 4,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    scrollDirection: Axis.vertical,
                    children: const [
                      CardHomeComponent(
                          label: 'Adicionar Animais',
                          icon: FontAwesomeIcons.plus,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Cadastrar Prenhez',
                          icon: FontAwesomeIcons.calendarPlus,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Cadastrar Antibiótico',
                          icon: FontAwesomeIcons.kitMedical,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Cadastrar Dieta',
                          icon: FontAwesomeIcons.wheatAwn,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Cadastrar Produção e Custo Mensal',
                          icon: FontAwesomeIcons.chartColumn,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Cotação dos Produitos Agrícolas',
                          icon: FontAwesomeIcons.seedling,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Previsão do Tempo',
                          icon: FontAwesomeIcons.cloudSun,
                          child: LoginPage()),
                      CardHomeComponent(
                          label: 'Gerar Relatórios',
                          icon: FontAwesomeIcons.fileLines,
                          child: LoginPage()),
                    ]),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
      drawer: MenuDrawer(),
    );
  }
}
