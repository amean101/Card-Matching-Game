import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

//Class that stores the model of the objects that represent the card
class CardModel {
  final int id;
  final String image;
  bool facedUp;
  bool cardMatched;

  CardModel({required this.id, required this.image})
    : facedUp = false,
      cardMatched = false;
}

//Class that manages the state of the game updating the UI
class GameProvider extends ChangeNotifier {
  List<CardModel> cards = [];
  CardModel? firstFlipped;
  bool cardCheck = false;

  GameProvider() {
    _initializeGame();
  }

  //Method that initializes the list of cards, randomly mixing them and changes the UI if needed
  void _initializeGame() {
    List<String> images = [
      'I',
      'I',
      'II',
      'II',
      'III',
      'III',
      'IV',
      'IV',
      'V',
      'V',
      'VI',
      'VI',
      'VII',
      'VII',
      'VIII',
      'VIII',
    ];
    images.shuffle();
    cards = List.generate(
      images.length,
      (index) => CardModel(id: index, image: images[index]),
    );
    notifyListeners();
  }

  //Method that changes UI depending on status of card
  void flipCard(CardModel card) {
    if (cardCheck || card.cardMatched || card.facedUp) return;
    card.facedUp = true;
    notifyListeners();

    if (firstFlipped == null) {
      firstFlipped = card;
    } else {
      cardCheck = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), () {
        if (firstFlipped!.image == card.image) {
          firstFlipped!.cardMatched = true;
          card.cardMatched = true;
        } else {
          firstFlipped!.facedUp = false;
          card.facedUp = false;
        }
        firstFlipped = null;
        cardCheck = false;
        notifyListeners();
      });
    }
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Card Matching Game')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: game.cards.length,
        itemBuilder: (context, index) {
          return FlipCard(card: game.cards[index]);
        },
      ),
    );
  }
}

class FlipCard extends StatelessWidget {
  final CardModel card;
  const FlipCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => game.flipCard(card),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: card.facedUp || card.cardMatched ? Colors.white : Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4.0)],
        ),
        child: Center(
          child: Text(
            card.facedUp || card.cardMatched ? card.image : '?',
            style: const TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
