import 'package:flutter/material.dart';
import 'package:hw3/card_game.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        title: 'Matching Card Game',
        home: const GameScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
