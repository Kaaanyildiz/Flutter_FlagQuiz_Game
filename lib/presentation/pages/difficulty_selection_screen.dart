import 'package:flutter/material.dart';
import 'package:flagquizgame/core/constants/app_animations.dart';
import 'package:flagquizgame/presentation/pages/flag_quiz_screen.dart';

class DifficultySelectionScreen extends StatelessWidget {
  final String gameMode;
  final String category;
  final int? timeLimit;
  final int? maxErrors;

  const DifficultySelectionScreen({
    super.key,
    required this.gameMode,
    required this.category,
    this.timeLimit,
    this.maxErrors,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF3F51B5);
    final Color accentColor = const Color(0xFFFF9800);

    // Oyun modu başlığını belirleyelim
    String gameTypeTitle;
    if (gameMode == 'time') {
      gameTypeTitle = "Zaman Yarışı";
    } else if (gameMode == 'streak') {
      gameTypeTitle = "Yarışma Modu";
    } else {
      gameTypeTitle = "Klasik Mod";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$gameTypeTitle - Zorluk Seviyesi",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.8),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kategori bilgisi gösterelim
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.category,
                      color: accentColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Seçilen Kategori: $category",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Zorluk seviyesi seçim başlığı
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: accentColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Zorluk seviyesini seçin",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 36),
              
              // Zorluk seviyeleri
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildDifficultyCard(
                      context,
                      "Kolay",
                      "Temel bayrakları tahmin edin",
                      Colors.green,
                      Icons.sentiment_very_satisfied,
                      () => _startGame(context, "easy"),
                    ),
                    const SizedBox(height: 16),
                    _buildDifficultyCard(
                      context,
                      "Orta",
                      "Daha zorlu bayrakları çözün",
                      Colors.orange,
                      Icons.sentiment_satisfied,
                      () => _startGame(context, "medium"),
                    ),
                    const SizedBox(height: 16),
                    _buildDifficultyCard(
                      context,
                      "Zor",
                      "Benzer bayrakları ayırt edin",
                      Colors.red,
                      Icons.sentiment_dissatisfied,
                      () => _startGame(context, "hard"),
                    ),
                    const SizedBox(height: 16),
                    _buildDifficultyCard(
                      context,
                      "Uzman",
                      "Tüm ülkelerin bayraklarını tahmin edin",
                      Colors.purple,
                      Icons.psychology,
                      () => _startGame(context, "expert"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Zorluk seviyesi kartı widget'ı
  Widget _buildDifficultyCard(
    BuildContext context,
    String title,
    String description,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withOpacity(0.7),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  // Oyunu başlatma fonksiyonu
  void _startGame(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      AppAnimations.pageTransition(
        FlagQuizScreen(
          gameMode: gameMode,
          category: category,
          difficulty: difficulty,
          timeLimit: timeLimit,
          maxErrors: maxErrors,
        ),
      ),
    );
  }
}