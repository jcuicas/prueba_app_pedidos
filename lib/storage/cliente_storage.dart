import 'dart:convert';
import 'dart:io';

import 'package:app_pedidos/models/client.dart';
import 'package:path_provider/path_provider.dart';

class ClienteStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/clientes.json');
  }

  Future<String> readClient() async {
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

  Future<File> writeClient(List<Cliente> clientes) async {
    final file = await _localFile;

    final String jsonClients = jsonEncode(clientes);

    //Escribir archivo
    return file.writeAsString(jsonClients);
  }
}
