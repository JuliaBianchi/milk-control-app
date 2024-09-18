import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:milkcontrolapp/components/appbar_component.dart';
import 'package:milkcontrolapp/components/elevatedbutton_component.dart';
import 'package:milkcontrolapp/components/textfield_component.dart';
import 'package:milkcontrolapp/pages/login_page.dart';
import 'package:milkcontrolapp/services/auth_service.dart';
import 'package:page_transition/page_transition.dart';

import '../components/snackbar_component.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerKey = GlobalKey<FormState>();

  final authService = AuthService();

  bool passwordVisible = true;
  bool passwordConfirmVisible = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  submitRegister() {
    final isValid = _registerKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    authService.register(
        email: _emailController.text,
        password: _passwordController.text,
    ).then((String? erro){
      if(erro != null){
        showSnackBar(context: context, message: erro, backgroundColor: Colors.red);
      }else{
        showSnackBar(context: context, message: 'Conta criada com sucesso!', backgroundColor: Colors.green);

        Navigator.push(
          context,
          PageTransition(
            child: const LoginPage(),
            childCurrent: const RegisterPage(),
            type: PageTransitionType.fade,
          ),
        );
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const AppbarComponent(),
              const Text(
                'Criar uma conta',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Preencha os campos abaixo com seus dados:',
                style: TextStyle(
                  color: Color(0xff4F4F4F),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Form(
                key: _registerKey,
                child: Column(
                  children: [
                    TextFieldComponent(
                      controller: _nameController,
                      hintText: 'Nome Completo',
                      filled: true,
                      fillColor: Colors.white,
                      validator: (value) {
                        if (value == null) {
                          return "Esse campo não pode ser vazio.";
                        }

                        if(value.length < 5){
                          return "Insira um nome válido.";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,


                    ),
                    TextFieldComponent(
                      controller: _phoneController,
                      hintText: 'Telefone',
                      filled: true,
                      fillColor: Colors.white,
                      validator: (value) {
                        if (value == null || value == '') {
                          return "O campo telefone deve ser preenchido.";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        TextInputMask(
                            mask: ['\\+ 99 (99) 9 9999-9999'])
                      ],
                    ),
                    TextFieldComponent(
                      controller: _emailController,
                      hintText: 'E-mail',
                      filled: true,
                      fillColor: Colors.white,
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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFieldComponent(
                      controller: _passwordController,
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return "Insira uma senha com mais caracteres.";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      obscureText: passwordVisible,
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
                    ),

                    TextFieldComponent(
                      controller: _confirmPasswordController,
                      hintText: 'Confirmar Senha',
                      filled: true,
                      fillColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return "Insira uma confirmação de senha válida.";
                        }
                        if (value != _passwordController.text) {
                          return "As senhas devem ser iguais.";
                        }
                        return null;

                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: passwordConfirmVisible,
                      suffixIcon: IconButton(
                        icon: passwordConfirmVisible
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
                            passwordConfirmVisible = !passwordConfirmVisible;
                          });
                        },
                      ),
                      onFieldSubmitted: (_) {
                        submitRegister();
                      },

                    ),
                  ],
                ),
              ),
              ElevatedButtonComponent(
                onPressed: () => submitRegister(),
                width: 200,
                text: 'Criar conta',
                colorText: Colors.white,
                color: const Color(0xff001F3D),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Já tem uma conta? ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(

                    onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                        child: const LoginPage(),
                        childCurrent: const RegisterPage(),
                        type: PageTransitionType.fade,
                      ),
                    ), child: const Text('Entrar',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff001F3D),
                        fontWeight: FontWeight.bold),
                  ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
