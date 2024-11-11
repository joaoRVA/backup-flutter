import 'package:flutter/material.dart';
import 'package:flutter_application_1/boasvindasscreen.dart';

void main() {
  runApp(FazendaApp());
}

class FazendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Controle de Estoque da Fazenda',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: BoasVindas(),
    );
  }
}