import 'dart:convert';
import 'dart:io';

import 'package:app_pedidos/models/user.dart';
import 'package:path_provider/path_provider.dart';

class UserStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/user.json');
  }

  Future<String> readUser() async {
    try {
      final file = await _localFile;

      //Leer archivo
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // Si encuaentra un error, returna una cadena vacia
      return '';
    }
  }

  Future<File> writeUser(String id, String fullName, String userEmail) async {
    final file = await _localFile;

    final user = Usuario(id: id, fullName: fullName, userEmail: userEmail);

    final String jsonUser = jsonEncode([user]);

    //Escribir archivo
    return file.writeAsString(jsonUser);
  }
}
