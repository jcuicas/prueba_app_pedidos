import 'dart:convert';
import 'dart:io';

import 'package:app_pedidos/models/product.dart';
import 'package:path_provider/path_provider.dart';

class ProductStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/productos.json');
  }

  Future<String> readProduct() async {
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

  Future<File> writeProduct(List<Producto> productos) async {
    final file = await _localFile;

    final String jsonProducts = jsonEncode(productos);

    //Escribir archivo
    return file.writeAsString(jsonProducts);
  }
}
