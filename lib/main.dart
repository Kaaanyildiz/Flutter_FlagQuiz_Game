import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart'; // firebase_core eklenmeli
import 'presentation/pages/flag_quiz_screen.dart'; // Bu ekranı kullanıyorsanız doğru yolu belirtin

void main() async {
  //WidgetsFlutterBinding.ensureInitialized(); // Flutter widget'larını başlatıyoruz
 //await Firebase.initializeApp(); // Firebase'i başlat
  runApp(const FlagQuizApp()); // Uygulamanı başlat
}

class FlagQuizApp extends StatelessWidget {
  const FlagQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FlagQuizScreen(), // Ana sayfa olarak FlagQuizScreen kullanılıyor
    );
  }
}
