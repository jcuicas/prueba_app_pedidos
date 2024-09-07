import 'package:app_pedidos/models/prices.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Precio>> obtenerDatos(String table) async {
  final response = await supabase.from(table).select('*');

  List<Precio> listaDatos = [];

  if (response.isNotEmpty) {
    for (var item in response) {
      listaDatos.add(
        Precio(
          id: item['id'].toString(),
          codigo: item['codigo'],
          precio: item['precio'].toString(),
          idProducto: item['idproducto'].toString(),
        ),
      );
    }

    return listaDatos;
  } else {
    return Future.error('Falló de conexión');
  }
}
