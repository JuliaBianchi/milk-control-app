import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/snackbar_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import 'package:milkcontrolapp/pages/forgot_password_page.dart';
import 'package:milkcontrolapp/pages/register_page.dart';
import 'package:page_transition/page_transition.dart';
import '../services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;

  Future<void> login() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    authService.login(email: emailController.text.trim(), password: passwordController.text.trim()).then((String? erro){

    if(erro == null){
      Navigator.push(
        context,
        PageTransition(
          child: const HomePage(),
          childCurrent: const LoginPage(),
          type: PageTransitionType.fade,
        ),
      );
    }else{
      showSnackBar(context: context, message: erro, backgroundColor: Colors.red);
    }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7ff),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/background-png.png',
                  height: 500,
                  fit: BoxFit.cover,
                )
              ],
            ),
            const SizedBox(height: 30),
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
                      padding: const EdgeInsets.all(8.0),
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
                    obscureText: _isObscure,
                    prefixIcon: Icon(
                      FontAwesomeIcons.key,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: IconButton(
                      icon: _isObscure
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
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_){
                      login();
                    },
                  ),
                  ElevatedButtonComponent(
                      text: 'Entrar',
                      colorText: Colors.white,
                      width: 150,
                      color: const Color(0xff1C6E8C),
                      onPressed: () async {
                        login();

                      }),
                  const SizedBox(height: 50),
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
    );
  }
}
