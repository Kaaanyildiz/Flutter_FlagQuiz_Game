import 'package:flutter/material.dart';
import 'package:flagquizgame/presentation/pages/category_selection_screen.dart';
import 'package:flagquizgame/presentation/pages/leaderboard_screen.dart';
import 'package:flagquizgame/core/constants/app_theme.dart';
import 'package:flagquizgame/core/constants/app_animations.dart';
import 'package:flagquizgame/presentation/pages/how_to_play/how_to_play_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.mainGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                
                // Logo ve başlık - animasyonlu
                Animate(
                  effects: [
                    FadeEffect(duration: 800.ms),
                    ScaleEffect(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 800.ms,
                      curve: Curves.easeOutBack,
                    ),
                  ],
                  child: Center(
                    child: Column(
                      children: [
                        // Animasyonlu bayrak logosu
                        Hero(
                          tag: 'app_logo',
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Arka plan ışıltı efekti
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor.withOpacity(0.3 + 0.2 * _animationController.value),
                                          blurRadius: 20 + 10 * _animationController.value,
                                          spreadRadius: 5 + 5 * _animationController.value,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // Bayrak ikonu
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.flag_rounded,
                                  size: 60,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Parlayan başlık
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.9),
                                Colors.white,
                              ],
                              stops: const [0.1, 0.3, 0.6],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.mirror,
                            ).createShader(bounds);
                          },
                          child: const Text(
                            "WORLD QUEST",
                            style: AppTheme.headingStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Oyun mod butonları - animasyonlu
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildAnimatedOptionCard(
                        context,
                        index: 0,
                        title: "KLASİK MOD",
                        description: "Standart bayrak tahmin etme oyunu",
                        icon: Icons.flag,
                        color: AppTheme.primaryColor,
                        onTap: () {
                          _navigateWithAnimation(
                            CategorySelectionScreen(
                              gameMode: 'classic',
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildAnimatedOptionCard(
                        context,
                        index: 1,
                        title: "ZAMAN YARIŞI",
                        description: "Sınırlı sürede en fazla bayrağı tahmin et",
                        icon: Icons.timer,
                        color: Colors.green[700]!,
                        onTap: () {
                          _navigateWithAnimation(
                            const CategorySelectionScreen(
                              gameMode: 'time',
                              timeLimit: 60,
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildAnimatedOptionCard(
                        context,
                        index: 2,
                        title: "YARIŞMA MODU",
                        description: "Üç yanlış hakkın var. Ne kadar ilerleyebilirsin?",
                        icon: Icons.emoji_events,
                        color: AppTheme.accentColor,
                        onTap: () {
                          _navigateWithAnimation(
                            const CategorySelectionScreen(
                              gameMode: 'streak',
                              maxErrors: 3,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Alt menü butonları - animasyonlu
                Animate(
                  effects: [
                    FadeEffect(delay: 800.ms, duration: 600.ms),
                    SlideEffect(
                      begin: const Offset(0, 30),
                      end: const Offset(0, 0),
                      delay: 800.ms,
                      duration: 600.ms,
                    ),
                  ],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircleButton(
                        context,
                        icon: Icons.leaderboard,
                        label: "Skor Tablosu",
                        onTap: () {
                          _navigateWithAnimation(const LeaderboardScreen());
                        },
                      ),
                      _buildCircleButton(
                        context,
                        icon: Icons.settings,
                        label: "Ayarlar",
                        onTap: () {
                          // Ayarlar menüsünü göster
                          _showSettingsDialog(context);
                        },
                      ),
                      _buildCircleButton(
                        context,
                        icon: Icons.help_outline,
                        label: "Nasıl Oynanır",
                        onTap: () {
                          _showHowToPlayDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedOptionCard(
    BuildContext context, {
    required int index,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Animate(
      effects: [
        FadeEffect(delay: (300 + index * 200).ms, duration: 800.ms),
        SlideEffect(
          begin: const Offset(30, 0),
          end: const Offset(0, 0),
          delay: (300 + index * 200).ms,
          duration: 800.ms,
          curve: Curves.easeOutQuart,
        ),
      ],
      child: _buildOptionCard(
        context,
        title: title,
        description: description,
        icon: icon,
        color: color,
        onTap: onTap,
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.1),
        highlightColor: color.withOpacity(0.05),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                    size: 36,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: color.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        splashColor: AppTheme.primaryColor.withOpacity(0.1),
        highlightColor: AppTheme.primaryColor.withOpacity(0.05),
        child: Ink(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Navigasyon ve dialog fonksiyonları
  void _navigateWithAnimation(Widget screen) {
    Navigator.push(
      context, 
      AppAnimations.pageTransition(screen),
    );
  }
  
  void _showSettingsDialog(BuildContext context) {
    bool soundEnabled = true; // Shared Preferences kullanarak depolanabilir
    bool darkMode = false; // Shared Preferences kullanarak depolanabilir
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                const Icon(
                  Icons.settings,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                const Text("Ayarlar"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ses ayarları
                Animate(
                  effects: const [
                    SlideEffect(
                      begin: Offset(-20, 0),
                      end: Offset(0, 0),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    ),
                    FadeEffect(
                      duration: Duration(milliseconds: 300),
                    ),
                  ],
                  child: SwitchListTile(
                    title: const Text("Ses Efektleri"),
                    subtitle: const Text("Oyun seslerini aç/kapat"),
                    value: soundEnabled,
                    activeColor: AppTheme.primaryColor,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        soundEnabled = value;
                        SoundEffects.isSoundEnabled = value;
                      });
                    },
                  ),
                ),
                
                // Tema ayarları
                Animate(
                  effects: const [
                    SlideEffect(
                      begin: Offset(-20, 0),
                      end: Offset(0, 0),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    ),
                    FadeEffect(
                      duration: Duration(milliseconds: 400),
                    ),
                  ],
                  child: SwitchListTile(
                    title: const Text("Karanlık Tema"),
                    subtitle: const Text("Karanlık/Aydınlık tema seçin"),
                    value: darkMode,
                    activeColor: AppTheme.primaryColor,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                        // Tema değişikliği (uygulamalı değil)
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tema özelliği yakında eklenecek"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
                
                // Dil ayarları
                Animate(
                  effects: const [
                    SlideEffect(
                      begin: Offset(-20, 0),
                      end: Offset(0, 0),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    ),
                    FadeEffect(
                      duration: Duration(milliseconds: 500),
                    ),
                  ],
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Dil"),
                    subtitle: const Text("Uygulama dilini değiştir"),
                    trailing: const Icon(Icons.language, color: AppTheme.primaryColor),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Dil desteği yakında eklenecek"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Kapat",
                  style: TextStyle(color: AppTheme.primaryColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showHowToPlayDialog(BuildContext context) {
    showHowToPlayScreen(context);
  }
}