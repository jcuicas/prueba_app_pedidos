import 'package:app_pedidos/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Producto>> obtenerDatosProductos(String table) async {
  final response = await supabase.from(table).select('*');

  List<Producto> listaDatos = [];

  if (response.isNotEmpty) {
    for (var item in response) {
      listaDatos.add(
        Producto(
          id: item['id'].toString(),
          codigo: item['codigo'],
          producto: item['producto'],
          idCategoria: item['idcategoria'].toString(),
          existencia: item['existencia'].toString(),
        ),
      );
    }

    return listaDatos;
  } else {
    return Future.error('Falló de conexión');
  }
}
