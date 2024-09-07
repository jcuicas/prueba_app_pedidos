import 'dart:convert';
import 'dart:io';

import 'package:app_pedidos/models/category.dart';
import 'package:path_provider/path_provider.dart';

class CategoriaStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/categoria.json');
  }

  Future<String> readCategoria() async {
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

  Future<File> writeCategoria(List<Categoria> categorias) async {
    final file = await _localFile;

    final String jsonCategorias = jsonEncode(categorias);

    //Escribir archivo
    return file.writeAsString(jsonCategorias);
  }
}
