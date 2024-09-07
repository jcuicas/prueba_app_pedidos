import 'dart:io';

import 'package:app_pedidos/components/my_user_account.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/screens/categorias.dart';
import 'package:app_pedidos/screens/clientes.dart';
import 'package:app_pedidos/screens/dashboard.dart';
import 'package:app_pedidos/screens/existencias.dart';
import 'package:app_pedidos/screens/historico_pedidos.dart';
import 'package:app_pedidos/screens/orden_pedidos.dart';
import 'package:app_pedidos/screens/ver_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        children: [
          Expanded(
            child: Column(
              children: [
                UserAccount(
                  userEmail: GetInfoUser.of(context).userEmail!,
                  fullName: GetInfoUser.of(context).fullName!,
                ),
                ListTile(
                  leading: Image.asset('assets/img/dashboard.png'),
                  title: const Text('Inicio'),
                  trailing: const Icon(
                    Icons.home,
                    color: Color(0xffec1c24),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Color(0xffec1c24),
                ),
                ListTile(
                  leading: Image.asset('assets/img/categorias.png'),
                  title: const Text('Categorias'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoCategoria(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/pedidos.png'),
                  title: const Text('Historico de pedidos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoPedidos(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/clientes.png'),
                  title: const Text('Clientes'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoCliente(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/existencias.png'),
                  title: const Text('Existencias'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoExistencias(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/order.png'),
                  title: const Text('Orden de pedido'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdenPedido(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/carrito.png'),
                  title: const Text('Carrito de pedidos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerPedidos(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffec1c24),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Color(0xffec1c24),
                    ),
                    title: const Text('Cerrar sesión'),
                    onTap: () {
                      logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    if (GetInfoUser.of(context).conexion!) {
      await supabase.auth.signOut();
    }

    exit(0); //Windows y android
    //SystemNavigator.pop(); //Android
  }
}
