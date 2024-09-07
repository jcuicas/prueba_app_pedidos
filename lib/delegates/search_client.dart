import 'package:app_pedidos/models/client.dart';
import 'package:flutter/material.dart';

class BuscarCliente extends SearchDelegate {
  final List<Cliente> listaClientes;
  List<Cliente> _filtroClientes = [];

  BuscarCliente({
    required this.listaClientes,
  });

  @override
  String? get searchFieldLabel => 'Buscar cliente';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Cliente> clientes = [];

    for (var item in listaClientes) {
      if (item.cliente.contains(
        query.toUpperCase().trim(),
      )) {
        clientes.add(
          Cliente(
            id: item.id,
            cliente: item.cliente,
            rif: item.rif,
            grupoCliente: item.grupoCliente,
          ),
        );
      }
    }

    return ListView.builder(
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                clientes[index].cliente.substring(0, 2),
              ),
            ),
            title: Text(clientes[index].cliente),
            subtitle: Text(clientes[index].rif),
            trailing: Text(clientes[index].grupoCliente),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroClientes = listaClientes.where(
      (cliente) {
        return cliente.cliente.contains(query.toUpperCase().trim());
      },
    ).toList();

    return ListView.builder(
      itemCount: _filtroClientes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _filtroClientes[index].cliente.substring(0, 2),
              ),
            ),
            title: Text(_filtroClientes[index].cliente),
            subtitle: Text(_filtroClientes[index].rif),
            trailing: Text(_filtroClientes[index].grupoCliente),
          ),
        );
      },
    );
  }
}
