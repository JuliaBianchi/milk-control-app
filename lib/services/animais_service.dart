
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/animal.dart';

class AnimaisService extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Animal>> getAnimals() async {
    QuerySnapshot snapshot = await _firestore
        .collection('animais')
        .orderBy('identificacao')
        .get();
    return snapshot.docs.map((doc) => Animal.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> adicionarAnimal(Animal animal) async {
    await _firestore.collection('animais').doc(animal.uuid).set(animal.toMap());
  }

  Future<void> editarAnimal(Animal animal) async {
    await _firestore.collection('animais').doc(animal.uuid).set(animal.toMap());
  }
}