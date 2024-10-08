import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/listtile_component.dart';
import 'package:milkcontrolapp/components/snackbar_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import 'package:milkcontrolapp/pages/animals_page.dart';
import 'package:milkcontrolapp/pages/login_page.dart';
import 'package:milkcontrolapp/services/auth_service.dart';
import 'package:page_transition/page_transition.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final TextEditingController _passwordController = TextEditingController();

  showRemoveAccountConfirmation(
      {required BuildContext context, required String email}) {
    showDialog(
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 2,
          title: const Text(
            'Confirmação de exclusão de conta',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Para confirmar a remoção da conta, insira sua senha.',
                  style: TextStyle(
                    color: Color(0xff4F4F4F),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFieldComponent(
                  obscureText: true,
                  controller: _passwordController,
                  hintText: 'Senha',
                  prefixIcon: Icon(
                    FontAwesomeIcons.key,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                AuthService()
                    .deleteAccount(password: _passwordController.text)
                    .then((String? erro) {
                  if (erro == null) {
                    showSnackBar(
                        context: context,
                        message: 'Conta excluída!',
                        backgroundColor: Colors.green);
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const LoginPage(),
                        childCurrent: const MenuDrawer(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  } else {
                    // snackbar / outro dialog / textfield
                    log(erro);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              child: const Text(
                'Confirmar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                _passwordController.clear();
                Navigator.of(context).pop();
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100, bottom: 50),
                  width: 250,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTileComponent(
                      icon: FontAwesomeIcons.cow,
                      label: 'Meus Animais',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const AnimalsPage(),
                            childCurrent: const MenuDrawer(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      }),
                  ListTileComponent(
                      icon: FontAwesomeIcons.chartSimple,
                      label: 'Minhas Dietas',
                      onTap: () {}),

                  ListTileComponent(
                      icon: FontAwesomeIcons.rightToBracket,
                      label: 'Sair',
                      onTap: () {
                        AuthService().logout().then((_) {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const LoginPage(),
                              childCurrent: const MenuDrawer(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        });
                      }),
                  ListTileComponent(
                      icon: FontAwesomeIcons.close,
                      label: 'Deletar conta',
                      onTap: () {
                        showRemoveAccountConfirmation(
                            context: context, email: '');
                      }),
                  ListTileComponent(
                      icon: FontAwesomeIcons.solidPenToSquare,
                      label: 'Quero ser assinante',
                      onTap: () {}),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
