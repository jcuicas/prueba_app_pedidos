import 'dart:convert';

import 'package:app_pedidos/models/product.dart';
import 'package:app_pedidos/storage/existencia_storage.dart';

final productoStorage = ProductStorage();

Future<List<Producto>> obtenerProductoLocal() async {
  final response = await productoStorage.readProduct();

  List<Producto> productos = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      productos.add(
        Producto(
          id: item['id'].toString(),
          codigo: item['codigo'],
          producto: item['producto'],
          idCategoria: item['idcategoria'].toString(),
          existencia: item['existencia'].toString(),
        ),
      );
    }
  }

  return productos;
}
