import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/models/product.dart';
import 'package:app_pedidos/providers/my_get_products.dart';
import 'package:app_pedidos/providers_off/my_get_product_off.dart';
import 'package:app_pedidos/storage/existencia_storage.dart';
import 'package:flutter/material.dart';

class ListadoExistencias extends StatefulWidget {
  const ListadoExistencias({super.key});

  @override
  State<ListadoExistencias> createState() => _ListadoExistenciasState();
}

class _ListadoExistenciasState extends State<ListadoExistencias> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Producto>> listaProductos;

  final productoStorage = ProductStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaProductos = obtenerDatosProductos('productos');
    } else {
      listaProductos = obtenerProductoLocal();
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
        future: listaProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verProductos(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No hay datos...'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> verProductos(List<Producto> datos) {
    List<Widget> productos = [];

    productos.add(Card(
      child: ListTile(
        title: const Text(
          'Listado de productos',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            /* showSearch(
              context: context,
              delegate: BuscarProducto(listaProductos: datos),
            ); */
          },
          icon: const Icon(Icons.search),
        ),
      ),
    ));

    for (var item in datos) {
      productos.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                item.producto.substring(0, 2),
              ),
            ),
            title: Text(item.producto),
            subtitle: Text(item.codigo),
            trailing: Text(item.existencia),
          ),
        ),
      );
    }

    productoStorage.writeProduct(datos);

    return productos;
  }
}
