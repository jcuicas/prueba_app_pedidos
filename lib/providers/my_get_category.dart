import 'package:app_pedidos/models/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Categoria>> obtenerDatos(String table) async {
  final response = await supabase.from(table).select('*');

  List<Categoria> listaDatos = [];

  if (response.isNotEmpty) {
    for (var item in response) {
      listaDatos.add(
        Categoria(
          id: item['id'].toString(),
          categoria: item['categoria'],
        ),
      );
    }

    return listaDatos;
  } else {
    return Future.error('Falló de conexión');
  }
}
