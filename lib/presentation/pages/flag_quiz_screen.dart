import 'dart:math';
import 'package:flagquizgame/core/constants/flag_data.dart';
import 'package:flagquizgame/data/models/flag_model.dart';
import 'package:flagquizgame/presentation/widgets/flag_option_button.dart';
import 'package:flutter/material.dart';
//import 'package:flagquizgame/services/firestore_services.dart';

class FlagQuizScreen extends StatefulWidget {
  const FlagQuizScreen({super.key});

  @override
  State<FlagQuizScreen> createState() => _FlagQuizScreenState();
}

class _FlagQuizScreenState extends State<FlagQuizScreen> {
  late List<FlagModel> _allFlags;
  late List<FlagModel> _currentOptions;
  late FlagModel _correctFlag;

  int _score = 0;
  int _questionCount = 0;
  bool _isAnswered = false;
  String? _selectedAnswer;

  final int _maxQuestions = 10;
 // final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadFlags();
    _generateQuestion();
  }

  void _loadFlags() {
    _allFlags = countryFlags.entries
        .map((entry) => FlagModel.fromMap(entry))
        .toList();
    _allFlags.shuffle();
  }

  void _generateQuestion() {
    _currentOptions = (_allFlags..shuffle()).take(4).toList();
    _correctFlag = _currentOptions[Random().nextInt(4)];
    _isAnswered = false;
    _selectedAnswer = null;
  }

  void _checkAnswer(String selected) {
    setState(() {
      _isAnswered = true;
      _selectedAnswer = selected;
      if (selected == _correctFlag.name) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_questionCount + 1 == _maxQuestions) {
        _showGameOverDialog();
      } else {
        setState(() {
          _questionCount++;
          _generateQuestion();
        });
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nameController = TextEditingController();
        return AlertDialog(
          title: const Text("Oyun Bitti"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Skorunuz: $_score / $_maxQuestions"),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "İsminiz",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: const Text("Yeniden Başla"),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  //await _firestoreService.saveScore(name, _score);
                  Navigator.of(context).pop();
                  _restartGame();
                }
              },
              child: const Text("Skoru Kaydet"),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _questionCount = 0;
      _loadFlags();
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bayrak Bilme Oyunu"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentOptions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${_questionCount + 1}. Soru",
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 16),
                  // Ortalanmış bayrak görseli
                  Center(
                    child: Image.network(
                      _correctFlag.imageUrl,
                      height: 180,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.flag, size: 100),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Şıkların yerleşimini ortalamak için Align kullanıyoruz
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _currentOptions.map(
                      (flag) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FlagOptionButton(
                            text: flag.name,
                            isCorrect: _isAnswered && flag.name == _correctFlag.name,
                            isSelected: _isAnswered && flag.name == _selectedAnswer,
                            isDisabled: _isAnswered,
                            onTap: () => _checkAnswer(flag.name),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Skorun ortalanmış şekilde gösterilmesi
                  Text(
                    "Skor: $_score / $_maxQuestions",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
