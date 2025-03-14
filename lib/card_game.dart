import 'package:flutter/material.dart';

class CardModel {
  final int id;
  final String image;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.id, required this.image})
      : isFaceUp = false,
        isMatched = false;
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 80, 80),
        title: const Text('Card Matching Game'),
      ),
    );
  }
}
