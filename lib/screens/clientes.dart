import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/delegates/search_client.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/providers/my_get_client.dart';
import 'package:app_pedidos/models/client.dart';
import 'package:app_pedidos/providers_off/my_get_client_off.dart';
import 'package:app_pedidos/storage/cliente_storage.dart';
import 'package:flutter/material.dart';

class ListadoCliente extends StatefulWidget {
  const ListadoCliente({
    super.key,
  });

  @override
  State<ListadoCliente> createState() => _ListadoClienteState();
}

class _ListadoClienteState extends State<ListadoCliente> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List<Cliente>> listaClientes;

  final clienteStorage = ClienteStorage();

  @override
  void initState() {
    super.initState();

    //listaClientes = obtenerDatos('clientes');
    //debugPrint(listaClientes.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaClientes = obtenerDatos('clientes');
    } else {
      listaClientes = obtenerClienteLocal();
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
        future: listaClientes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verClientes(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'No hay datos...',
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

  List<Widget> verClientes(List<Cliente> datos) {
    List<Widget> clientes = [];

    clientes.add(Card(
      child: ListTile(
        title: Text(
          'Listado de clientes',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: BuscarCliente(listaClientes: datos));
          },
          icon: Icon(Icons.search),
        ),
      ),
    ));

    for (var item in datos) {
      clientes.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                item.cliente.substring(0, 2),
              ),
            ),
            title: Text(item.cliente),
            subtitle: Text(item.rif),
            trailing: Text(item.grupoCliente),
          ),
        ),
      );
    }

    clienteStorage.writeClient(datos);

    return clientes;
  }
}
