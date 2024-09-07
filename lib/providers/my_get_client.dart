import 'package:app_pedidos/models/client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Cliente>> obtenerDatos(String table) async {
  final response = await supabase.from(table).select('*');

  List<Cliente> listaDatos = [];

  if (response.isNotEmpty) {
    for (var item in response) {
      listaDatos.add(
        Cliente(
          id: item['id'].toString(),
          cliente: item['cliente'],
          rif: item['rif'],
          grupoCliente: item['grupo_cliente'],
        ),
      );
    }

    return listaDatos;
  } else {
    return Future.error('Falló de conexión');
  }
}
