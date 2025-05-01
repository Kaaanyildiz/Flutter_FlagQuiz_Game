import 'package:flutter/material.dart';
import 'package:flagquizgame/core/constants/flag_categories.dart';
import 'package:flagquizgame/core/constants/app_animations.dart';
import 'package:flagquizgame/presentation/pages/difficulty_selection_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  final String gameMode;
  final int? timeLimit;
  final int? maxErrors;

  const CategorySelectionScreen({
    super.key,
    required this.gameMode,
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
          "$gameTypeTitle - Kategori Seçimi",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kategori seçim başlığı
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
                    const Expanded(
                      child: Text(
                        "Oynamak istediğiniz kategoriyi seçin",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Kıta kategorileri başlığı
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Text(
                  "Kıtalar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              
              // Kıtalar grid - daha büyük ve daha net
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5, // Daha geniş kartlar
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCategoryCard(
                      context,
                      "Tümü",
                      Icons.public,
                      primaryColor,
                      () => _navigateToDifficultyScreen(context, "Tümü"),
                    ),
                    ...FlagCategories.continentCountries.keys.map((continent) => 
                      _buildCategoryCard(
                        context,
                        continent,
                        _getContinentIcon(continent),
                        _getContinentColor(continent),
                        () => _navigateToDifficultyScreen(context, continent),
                      ),
                    ).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kategori kartı widget'ı - kıtalar için daha büyük
  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                size: 32, // Daha büyük ikon
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16, // Daha büyük yazı
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Zorluk seviyeleri ekranına geçiş
  void _navigateToDifficultyScreen(BuildContext context, String category) {
    Navigator.push(
      context,
      AppAnimations.pageTransition(
        DifficultySelectionScreen(
          gameMode: gameMode,
          timeLimit: timeLimit,
          maxErrors: maxErrors,
          category: category,
        ),
      ),
    );
  }

  // Kıtalara göre ikon belirleme
  IconData _getContinentIcon(String continent) {
    switch (continent) {
      case 'Avrupa':
        return Icons.euro;
      case 'Asya':
        return Icons.temple_buddhist;
      case 'Amerika':
        return Icons.location_city;
      case 'Afrika':
        return Icons.terrain;
      case 'Okyanusya':
        return Icons.waves;
      default:
        return Icons.flag;
    }
  }

  // Kıtalara göre renk belirleme
  Color _getContinentColor(String continent) {
    switch (continent) {
      case 'Avrupa':
        return Colors.blue[700]!;
      case 'Asya':
        return Colors.red[700]!;
      case 'Amerika':
        return Colors.purple[700]!;
      case 'Afrika':
        return Colors.amber[800]!;
      case 'Okyanusya':
        return Colors.teal[700]!;
      default:
        return Colors.indigo;
    }
  }
}