import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milkcontrolapp/components/appbar_component.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/textfield_code_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  Future<void> _showVerificationCodeDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: 380,
              width: 600,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Código de verificação',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Por favor, escreva o código de verificação \nque foi enviado pelo seu e-mail.',
                        style: TextStyle(
                          color: Color(0xff4F4F4F),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldCodeComponent(
                          labelText: '0',
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        TextFieldCodeComponent(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        TextFieldCodeComponent(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        TextFieldCodeComponent(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reenviar código depois de: 2:00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff001F3D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        child: const Text(
                          'Reenviar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffDF4F4F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
                      ' Não se preocupe, estamos aqui para ajudar! \n Por favor, digite abaixo o seu CPF ou e-mail cadastrado para receber o código de verificação.',
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
              const Form(
                child: TextFieldComponent(
                  hintText: 'Digite aqui o CPF ou e-mail cadastrado',
                ),
              ),
              ElevatedButtonComponent(
                onPressed: () => _showVerificationCodeDialog(context),
                width: 200,
                text: 'Enviar código',
                color: const Color(0xff1C6E8C),
              )
            ],
          ),
        ),
      ),
    );
  }
}
