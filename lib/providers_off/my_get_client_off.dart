import 'dart:convert';

import 'package:app_pedidos/models/client.dart';
import 'package:app_pedidos/storage/cliente_storage.dart';

final clienteStorage = ClienteStorage();

Future<List<Cliente>> obtenerClienteLocal() async {
  final response = await clienteStorage.readClient();

  List<Cliente> clientes = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      clientes.add(
        Cliente(
          id: item['id'].toString(),
          cliente: item['cliente'],
          rif: item['rif'],
          grupoCliente: item['grupo_cliente'],
        ),
      );
    }
  }

  return clientes;
}
