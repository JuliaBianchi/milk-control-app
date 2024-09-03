import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import 'package:milkcontrolapp/pages/forgot_password_page.dart';
import 'package:milkcontrolapp/pages/register_page.dart';
import 'package:page_transition/page_transition.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  Future<void> login() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    Navigator.push(
      context,
      PageTransition(
        child: const HomePage(),
        childCurrent: const LoginPage(),
        type: PageTransitionType.fade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          // Color(0xffeef8ff),
          Color(0xfff7f7ff),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/background.png',
                    height: 400,
                  )
                ],
              ),
              SvgPicture.asset(
                'lib/assets/undraw_join_re_w1lh.svg',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 50),
              const Text(
                'GESTOR DE PROPRIEDADE RURAL',
                style: TextStyle(
                    color: Color(0xff1C6E8C), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldComponent(
                      hintText: 'E-mail',
                      controller: emailController,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.solidEnvelope,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFieldComponent(
                      hintText: 'Senha',
                      controller: passwordController,
                      obscureText: passwordVisible,
                      prefixIcon: Icon(
                        FontAwesomeIcons.key,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      suffixIcon: IconButton(
                        icon: passwordVisible
                            ? Icon(
                                Icons.visibility,
                                color: Colors.grey.shade600,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.grey.shade600,
                              ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    ElevatedButtonComponent(
                        text: 'Entrar',
                        width: 150,
                        color: Color(0xff1C6E8C),
                        onPressed: () async {
                          await login();
                        }),
                    SizedBox(height: 50),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                          child: const ForgotPasswordPage(),
                          childCurrent: const LoginPage(),
                          type: PageTransitionType.fade,
                        ),
                      ),
                      child: const Text(
                        'Esqueceu a senha? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff1C6E8C),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Você é novo por aqui? ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff656563),
                              fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                              child: const RegisterPage(),
                              childCurrent: const LoginPage(),
                              type: PageTransitionType.fade,
                            ),
                          ),
                          child: const Text(
                            'Registre-se',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff1C6E8C),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
