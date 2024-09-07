import 'dart:convert';
import 'dart:io';

import 'package:app_pedidos/models/prices.dart';
import 'package:path_provider/path_provider.dart';

class PrecioStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/precios.json');
  }

  Future<String> readPrice() async {
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

  Future<File> writePrice(List<Precio> precios) async {
    final file = await _localFile;

    final String jsonPrices = jsonEncode(precios);

    //Escribir archivo
    return file.writeAsString(jsonPrices);
  }
}
