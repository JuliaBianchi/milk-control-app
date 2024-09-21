class UserModel {
  String uid;
  String? name;
  String? phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
  });

  // Método para criar um objeto User a partir de um Map (como os dados do Firestore)
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId, // O UID é o ID do documento
      name: data['nome'] as String?,
      phone: data['phone'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
    };
  }
}
