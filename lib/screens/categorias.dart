import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/delegates/search_category.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/models/category.dart';
import 'package:app_pedidos/providers/my_get_category.dart';
import 'package:app_pedidos/providers_off/my_get_category_off.dart';
import 'package:app_pedidos/storage/categoria_storage.dart';
import 'package:flutter/material.dart';

class ListadoCategoria extends StatefulWidget {
  const ListadoCategoria({super.key});

  @override
  State<ListadoCategoria> createState() => _ListadoCategoriaState();
}

class _ListadoCategoriaState extends State<ListadoCategoria> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Categoria>> listaCategorias;

  final categoriaStorage = CategoriaStorage();

  @override
  void initState() {
    super.initState();

    //listaCategorias = obtenerDatos('categorias');
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaCategorias = obtenerDatos('categorias');
    } else {
      listaCategorias = obtenerCategoriaLocal();
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: FutureBuilder(
        future: listaCategorias,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verCategorias(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'No hay datos',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> verCategorias(List<Categoria> datos) {
    List<Widget> categorias = [];

    categorias.add(Card(
      child: ListTile(
        title: Text(
          'Lista de categorias',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: BuscarCategoria(listaCategorias: datos),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ),
    ));

    for (var item in datos) {
      categorias.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(item.categoria.substring(0, 2)),
            ),
            title: Text(item.categoria),
          ),
        ),
      );
    }

    categoriaStorage.writeCategoria(datos);

    return categorias;
  }
}
