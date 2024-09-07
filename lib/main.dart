import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bechcokenkbxvsuxvbaj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJlY2hjb2tlbmtieHZzdXh2YmFqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU0MzQ0OTUsImV4cCI6MjAzMTAxMDQ5NX0.sqX-H082FtwKdBjs02JFcndo10gpye2NBk-dwPS3bxI',
  );

  runApp(const MyAppPedidos());
}

class MyAppPedidos extends StatelessWidget {
  const MyAppPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    const String tituloApp = 'DAF C.A.';

    return GetInfoUser(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: tituloApp,
        theme:
            ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        home: HomeScreen(
          titulo: tituloApp,
        ),
      ),
    );
  }
}
