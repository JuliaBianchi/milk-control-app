
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milkcontrolapp/components/appbar_homepage.dart';
import 'package:milkcontrolapp/components/card_home_component.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/menu_drawer.dart';
import 'package:milkcontrolapp/pages/cadastro_custos.dart';
import 'package:milkcontrolapp/pages/cadastro_producao.dart';
import 'package:milkcontrolapp/pages/cadastro_dieta.dart';
import 'package:milkcontrolapp/pages/cadastro_prenhez.dart';
import 'package:milkcontrolapp/pages/login_page.dart';
import 'package:milkcontrolapp/pages/relatorios.dart';
import 'animal_registration.dart';
import 'cadastro_antibiotico.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomePage> {
  final _scaffoldKeyPontoEletronico = GlobalKey<ScaffoldState>();

  File? _image;
  String? username;


  Future<void> getUserInfo() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    username = _firebaseAuth.currentUser?.displayName;
    print(_firebaseAuth.currentUser?.providerData);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKeyPontoEletronico,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppbarHomepage(
                nome: username ?? '',
                leading: 'assets/icons/bars-3.svg',
                trailing: 'assets/icons/bell.svg',
                onPressedLeading: (){
                  if (_scaffoldKeyPontoEletronico.currentState!.isDrawerOpen) {
                    _scaffoldKeyPontoEletronico.currentState!.closeDrawer();
                  } else {
                    _scaffoldKeyPontoEletronico.currentState!.openDrawer();
                  }
                },
              ),

              ConnectionNotifierToggler(
                onConnectionStatusChanged: (connected) {
                  if (connected == null) return;
                },
                connected: Center(
                  key: UniqueKey(),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.wifi, size: 20,),
                        SizedBox(width: 10),
                        Text('Conectado', style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                disconnected: Center(
                  key: UniqueKey(),
                  child: const Padding(
                      padding: EdgeInsets.only(left: 25, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.wifi_off, size: 20,),
                          SizedBox(width: 10),
                          Text('Sem acesso à internet', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
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
                          child: AnimalRegistration()),
                      CardHomeComponent(
                          label: 'Cadastrar Prenhez',
                          icon: FontAwesomeIcons.calendarPlus,
                          child: CadastroPrenhez()),
                      CardHomeComponent(
                          label: 'Cadastrar Antibiótico',
                          icon: FontAwesomeIcons.kitMedical,
                          child: CadastroAntibiotico()),
                      CardHomeComponent(
                          label: 'Cadastrar Dieta',
                          icon: FontAwesomeIcons.wheatAwn,
                          child: CadastroDieta()),
                      CardHomeComponent(
                          label: 'Cadastrar Produção',
                          icon: FontAwesomeIcons.chartColumn,
                          child: CadastroProducao()),
                      CardHomeComponent(
                          label: 'Cadastrar Custos',
                          icon: FontAwesomeIcons.chartColumn,
                          child: CadastroCustos()),
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
                          child: RelatoriosPage()),
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
