import 'dart:convert';

import 'package:app_pedidos/models/category.dart';
import 'package:app_pedidos/storage/categoria_storage.dart';

final categoriaStorage = CategoriaStorage();

Future<List<Categoria>> obtenerCategoriaLocal() async {
  final response = await categoriaStorage.readCategoria();

  List<Categoria> categorias = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      categorias.add(
        Categoria(
          id: item['id'],
          categoria: item['categoria'],
        ),
      );
    }
  }

  return categorias;
}
