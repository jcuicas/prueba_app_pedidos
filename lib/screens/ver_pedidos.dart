import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VerPedidos extends StatefulWidget {
  const VerPedidos({super.key});

  @override
  State<VerPedidos> createState() => _VerPedidosState();
}

class _VerPedidosState extends State<VerPedidos> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String dateNow = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: ListView(children: [
        Card(
          child: ListTile(
            leading: Image.asset('assets/img/carrito.png'),
            title: Text(
              'Carrito de pedidos',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            subtitle: Text('Pedidos por enviar al $dateNow'),
          ),
        ),
        Center(
          child: Text('Ver carrito de pedidos'),
        ),
      ]),
    );
  }
}
