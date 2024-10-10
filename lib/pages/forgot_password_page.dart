import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milkcontrolapp/components/appbar_component.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/snackbar_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import '../services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  _showVerificationCodeDialog() {
    showDialog(
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 2,
          title: const Text(
            'Confirmação de e-mail',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                const Text(
                  'Por favor, verifique se o e-mail informado foi digitado corretamente:',
                  style: TextStyle(
                    color: Color(0xff4F4F4F),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Text(
                  _emailController.text,
                  style: const TextStyle(
                    color: Color(0xff4F4F4F),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                authService
                    .forgotPassword(email: _emailController.text.trim())
                    .then((String? erro) {

                      showSnackBar(context: context, message: erro ?? 'Se o e-mail estiver cadastrado, um link de redefinição de senha será enviado.', backgroundColor: const Color(0xff6699CC));
                      _emailController.clear();

                      Navigator.pop(context);
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
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              child: const Text(
                'Voltar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );

  }

  final authService = AuthService();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const AppbarComponent(),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: const Column(
                  children: [
                    Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ' Não se preocupe, estamos aqui para ajudar! \n Por favor, digite abaixo o seu e-mail cadastrado para receber as informações de redefinição de senha.',
                      style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Form(
                child: TextFieldComponent(
                  controller: _emailController,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.solidEnvelope,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  hintText: 'E-mail',
                  validator: (value) {
                    if (value == null || value == "") {
                      return "O valor de e-mail deve ser preenchido";
                    }

                    if (!value.contains("@") ||
                        !value.contains(".") ||
                        value.length < 4) {
                      return "O valor do e-mail deve ser válido";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButtonComponent(
                onPressed: () {
                  _showVerificationCodeDialog();
                },
                width: 200,
                text: 'Enviar código',
                colorText: Colors.white,
                color: const Color(0xff1C6E8C),
              )
            ],
          ),
        ),
      ),
    );
  }
}
