import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  login({required String email, required String password}){
    print('login');
  }

  register({required String email, required String nome, required String phone, required String password}){
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

}