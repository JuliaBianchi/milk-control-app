import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        case 'too-many-requests':
          return 'O acesso à conta foi desativado temporariamente por várias tentativas de login falhas. Tente novamente mais tarde.';
        case 'invalid-credential':
          return 'E-mail ou senha incorretos';
        case 'channel-error':
          return 'Os campos de e-mail e senha não podem ser vazios';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> register({required String email, required String password, required String name, required String phone}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'phone': phone,
      });


    } on FirebaseAuthException catch (e) {
      switch(e.code){
        case "email-already-in-use":
          return "Esse e-mail já está cadastrado";
      }
      return e.code;
    }
    return null;
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
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(_firebaseAuth.currentUser?.uid);

    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: _firebaseAuth.currentUser!.email!, password: password);

      await userDoc.delete();
      await _firebaseAuth.currentUser!.delete();

    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case 'invalid-credential':
          return 'E-mail ou senha incorretos';
        case 'too-many-requests':
          return 'O acesso à conta foi desativado temporariamente por várias tentativas de login falhas. Tente novamente mais tarde.';
      }
      return e.code;
    }
    return null;
  }
}