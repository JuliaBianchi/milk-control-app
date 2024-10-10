import 'package:flutter/cupertino.dart';
import 'package:milkcontrolapp/services/animais_service.dart';

import '../models/animal.dart';

class AnimalProvider with ChangeNotifier {
  final AnimaisService _firestoreService = AnimaisService();


  List<Animal> _animals = [];

  bool _isLoading = false;

  String? _errorMessage;

  List<Animal> get animals => _animals;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchAnimals() async {

    _setLoading(true);
    _setErrorMessage(null);


    try {
      _animals = await _firestoreService.getAnimals();
    } catch (e) {
      _setErrorMessage('Erro ao buscar lista de animais: ${e.toString()}');
    }

    _setLoading(false);

  }

  Future<void> addAnimals(Animal animal) async {

    _setLoading(true);
    _setErrorMessage(null);

    try {
      _firestoreService.adicionarAnimal(animal);

    } catch (e) {
      _setErrorMessage('Erro ao adicionar animal: ${e.toString()}');
    }

    _setLoading(false);

  }

  Future<void> editAnimal(Animal animal) async {

    _setLoading(true);
    _setErrorMessage(null);

    try {
      _firestoreService.editarAnimal(animal);

    } catch (e) {
      _setErrorMessage('Erro ao editar animal: ${e.toString()}');
    }

    _setLoading(false);

  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}