import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/listtile_component.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 250,
              child: Image.asset(
                'lib/assets/logo.png',
              ),
            ),
          ],
        ),
        Positioned(
          top: 140,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: 350,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 50, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTileComponent(
                      icon: Icons.person, label: 'Meu Perfil', onTap: () {}),
                  ListTileComponent(
                      icon: FontAwesomeIcons.cow,
                      label: 'Meus Animais',
                      onTap: () {}),
                  ListTileComponent(
                      icon: FontAwesomeIcons.chartSimple,
                      label: 'Minhas Dietas',
                      onTap: () {}),
                  ListTileComponent(
                      icon: FontAwesomeIcons.dollarSign,
                      label: 'Custos / Ganhos',
                      onTap: () {}),
                  ListTileComponent(
                      icon: FontAwesomeIcons.globe,
                      label: 'Sincronizar',
                      onTap: () {}),
                  ListTileComponent(
                      icon: FontAwesomeIcons.solidPenToSquare,
                      label: 'Quero ser assinante',
                      onTap: () {}),
                  ListTileComponent(
                      icon: FontAwesomeIcons.rightToBracket,
                      label: 'Sair',
                      onTap: () {
                        Navigator.of(context).pushNamed('/login');
                      }),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
