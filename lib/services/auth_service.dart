import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {

      log(e.code);
      switch(e.code){
        case 'user-not-found':
          return 'O e-mail não está cadastrado';
        case 'wrong-password':
          return 'Senha incorreta';
        case 'invalid-email':
          return 'E-mail ou senha incorretos';
        case 'channel-error':
          return 'Os campos de e-mail e senha não podem ser vazios';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> register({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      switch(e.code){
        case "email-already-in-use":
          return "Esse e-mail já está cadastrado";
      }
      return e.code;
    }
    return null;

    // criar o usuário
    // criar o usuário no firestore
    // fazer o login na aplicação
    // UserModel userModel = UserModel(email: email, nome: nome, phone: phone, password: password);

  }

  Future<String?> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Se o e-mail estiver cadastrado, um link de redefinição de senha será enviado.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'O e-mail está inválido, verifique suas credenciais.';
      }
      return 'Ocorreu um erro ao tentar enviar o e-mail de redefinição de senha.';
    }
  }

  Future<String?> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }

    return null;
  }

  Future<String?> deleteAccount({required String password}) async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: _firebaseAuth.currentUser!.email!, password: password);

      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }
}