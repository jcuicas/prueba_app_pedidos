import 'dart:convert';

import 'package:app_pedidos/models/prices.dart';
import 'package:app_pedidos/storage/precio_storage.dart';

final precioStorage = PrecioStorage();

Future<List<Precio>> obtenerPrecioLocal() async {
  final response = await precioStorage.readPrice();

  List<Precio> precios = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      precios.add(
        Precio(
          id: item['id'].toString(),
          codigo: item['codigo'],
          idProducto: item['idproducto'].toString(),
          precio: item['precio'].toString(),
        ),
      );
    }
  }

  return precios;
}
