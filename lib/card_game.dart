import 'package:flutter/material.dart';

//Class that stores the model of the objects that represent the card
class CardModel {
  final int id;
  final String image;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.id, required this.image})
      : isFaceUp = false,
        isMatched = false;
}

//Class that manages the state of the game updating the UI 
class GameProvider extends ChangeNotifier {
  List<CardModel> cards = [];
  CardModel? firstFlipped;
  bool isProcessing = false;

  GameProvider() {
    _initializeGame();
  }

//Method that initializes the list of cards, randomly mixing them and changes the UI if needed
  void _initializeGame() {
    List<String> images = [
      'I', 'I', 'II', 'II', 'III', 'III', 'IV', 'IV',
      'V', 'V', 'VI', 'VI', 'VII', 'VII', 'VIII', 'VIII'
    ];
    images.shuffle();
    cards = List.generate(images.length, (index) => CardModel(id: index, image: images[index]));
    notifyListeners();
  }

  //Method that changes UI depending on status of card
  void flipCard(CardModel card) {
    if (isProcessing || card.isMatched || card.isFaceUp) return;
    card.isFaceUp = true;
    notifyListeners();

    if (firstFlipped == null) {
      firstFlipped = card;
    } else {
      isProcessing = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), () {
        if (firstFlipped!.image == card.image) {
          firstFlipped!.isMatched = true;
          card.isMatched = true;
        } else {
          firstFlipped!.isFaceUp = false;
          card.isFaceUp = false;
        }
        firstFlipped = null;
        isProcessing = false;
        notifyListeners();
      });
    }
  }
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
