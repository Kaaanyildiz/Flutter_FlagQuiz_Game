import 'package:flutter/material.dart';

/// Tüm uygulamada kullanılacak temalar, renkler ve stiller için sınıf
class AppTheme {
  // Ana renkler
  static const Color primaryColor = Color(0xFF1E3A8A); // Koyu mavi
  static const Color accentColor = Color(0xFFFF5722); // Turuncu
  static const Color backgroundColor = Colors.white;
  static const Color correctAnswerColor = Color(0xFF4CAF50); // Yeşil
  static const Color wrongAnswerColor = Color(0xFFF44336); // Kırmızı
  static const Color neutralColor = Color(0xFF9E9E9E); // Gri
  
  // Gradyan arka planlar
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF142F75), // Daha koyu mavi
      Color(0xFF1E3A8A), // Ana mavi
      Color(0xFF2F59C2), // Daha açık mavi
    ],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF5722), // Turuncu
      Color(0xFFFF8A65), // Açık turuncu
    ],
  );
  
  // Metin stilleri
  static const TextStyle headingStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.2,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.8,
  );
  
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
  
  // Kutu dekorasyonları
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
  
  static BoxDecoration flagDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.1),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );
  
  // Giriş animasyonları için gecikmeler
  static const Duration staggeredAnimationDelay = Duration(milliseconds: 100);
}

/// Ses efektleri için yardımcı sınıf
class SoundEffects {
  static bool isSoundEnabled = true;
  
  // Ses dosyaları geçici olarak devre dışı bırakıldı
  // Dosyalar eklendiğinde aktifleştirilebilir
  static const String correctAnswerSound = ''; // 'assets/sounds/correct.mp3'
  static const String wrongAnswerSound = '';   // 'assets/sounds/wrong.mp3'
  static const String clickSound = '';         // 'assets/sounds/click.mp3'
  static const String successSound = '';       // 'assets/sounds/success.mp3'
  static const String gameOverSound = '';      // 'assets/sounds/game_over.mp3'
}