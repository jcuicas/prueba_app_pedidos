import 'dart:async';

import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/screens/login.dart';
import 'package:app_pedidos/screens/dashboard.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  final String titulo;

  const HomeScreen({
    super.key,
    required this.titulo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _conexion = _connectionStatus[0] == ConnectivityResult.mobile ||
        _connectionStatus[0] == ConnectivityResult.wifi;

    GetInfoUser.of(context).setConexion(_conexion);

    return Scaffold(
      body: _conexion ? Login() : Dashboard(),
      backgroundColor: Colors.grey[300],
    );
  }
}
