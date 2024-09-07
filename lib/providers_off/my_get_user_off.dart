import 'dart:convert';

import 'package:app_pedidos/models/user.dart';
import 'package:app_pedidos/storage/user_storage.dart';

final userStorage = UserStorage();

Future<List<Usuario>> obtenerUsuarios() async {
  final response = await userStorage.readUser();

  List<Usuario> usuarios = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      usuarios.add(
        Usuario(
            id: item['id'],
            fullName: item['full_name'],
            userEmail: item['email']),
      );
    }
  }

  return usuarios;
}
