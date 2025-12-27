import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // <--- Importante: Isso conecta com a tela que criamos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(), // <--- Aqui chamamos a tela Home do seu exercício
    );
  }
}