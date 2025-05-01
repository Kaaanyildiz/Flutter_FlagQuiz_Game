import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flagquizgame/data/models/score_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flagquizgame/main.dart' show isFirebaseInitialized;

class FirestoreService {
  FirebaseFirestore? _db;
  final String _scoresCollection = 'scores';

  FirestoreService() {
    if (isFirebaseInitialized) {
      _db = FirebaseFirestore.instance;
    }
  }

  // Skor kaydetme
  Future<void> saveScore(ScoreModel score) async {
    // Firebase başlatılmadıysa işlem yapma
    if (_db == null) {
      debugPrint("Firebase başlatılmadığı için skor kaydedilemedi");
      return;
    }
    
    try {
      await _db!.collection(_scoresCollection).add(score.toMap());
    } catch (e) {
      debugPrint("Firestore score kaydetme hatası: $e");
      // Hatayı yukarı fırlatma, sadece loglama yap
    }
  }

  // Belirli bir oyun modu ve kategoriye göre skorları getirme
  Future<List<ScoreModel>> getScores({
    String gameMode = 'classic',
    String category = 'Tümü',
    int limit = 20,
  }) async {
    // Firebase başlatılmadıysa boş liste dön
    if (_db == null) {
      debugPrint("Firebase başlatılmadığı için skor getirilemedi");
      return [];
    }
    
    try {
      final querySnapshot = await _db!
          .collection(_scoresCollection)
          .where('gameMode', isEqualTo: gameMode)
          .where('category', isEqualTo: category)
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => ScoreModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint("Firestore skor getirme hatası: $e");
      return [];
    }
  }

  // Tüm oyun modları için en yüksek skorları getirme
  Future<List<ScoreModel>> getTopScores({int limit = 20}) async {
    // Firebase başlatılmadıysa boş liste dön
    if (_db == null) {
      debugPrint("Firebase başlatılmadığı için top skorlar getirilemedi");
      return _getDummyScores(); // Firebase yoksa örnek skorlar döndür
    }
    
    try {
      final querySnapshot = await _db!
          .collection(_scoresCollection)
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => ScoreModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      debugPrint("Firestore top skorları getirme hatası: $e");
      return _getDummyScores(); // Hata durumunda örnek skorlar döndür
    }
  }
  
  // Firebase olmadığında kullanılacak örnek skorlar
  List<ScoreModel> _getDummyScores() {
    return [
      ScoreModel(
        id: 'dummy1',
        playerName: 'Oyuncu1',
        score: 95,
        gameMode: 'classic',
        category: 'Tümü',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ScoreModel(
        id: 'dummy2',
        playerName: 'Oyuncu2',
        score: 85,
        gameMode: 'classic',
        category: 'Avrupa',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ),
      ScoreModel(
        id: 'dummy3',
        playerName: 'Oyuncu3',
        score: 75,
        gameMode: 'time',
        category: 'Tümü',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ScoreModel(
        id: 'dummy4',
        playerName: 'Oyuncu4',
        score: 65,
        gameMode: 'streak',
        category: 'Asya',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
      ),
      ScoreModel(
        id: 'dummy5',
        playerName: 'Oyuncu5',
        score: 55,
        gameMode: 'classic',
        category: 'Afrika',
        timestamp: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }
}
