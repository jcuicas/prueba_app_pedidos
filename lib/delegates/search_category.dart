import 'package:app_pedidos/extensions/extension_string.dart';
import 'package:app_pedidos/models/category.dart';
import 'package:flutter/material.dart';

class BuscarCategoria extends SearchDelegate {
  final List<Categoria> listaCategorias;
  List<Categoria> _filtroCategorias = [];

  BuscarCategoria({
    required this.listaCategorias,
  });

  @override
  String? get searchFieldLabel => 'Buscar categoria';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Categoria> categorias = [];

    for (var item in listaCategorias) {
      if (item.categoria.contains(
        query.isNotEmpty ? query.capitalize().trim() : query = '',
      )) {
        categorias.add(
          Categoria(
            id: item.id,
            categoria: item.categoria,
          ),
        );
      }
    }

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                categorias[index].categoria.substring(0, 2),
              ),
            ),
            title: Text(categorias[index].categoria),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroCategorias = listaCategorias.where(
      (categoria) {
        return categoria.categoria.contains(
            query.isNotEmpty ? query.capitalize().trim() : query = '');
      },
    ).toList();

    return ListView.builder(
      itemCount: _filtroCategorias.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _filtroCategorias[index].categoria.substring(0, 2),
              ),
            ),
            title: Text(_filtroCategorias[index].categoria),
          ),
        );
      },
    );
  }
}
