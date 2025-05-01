import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreModel {
  final String id;
  final String playerName;
  final int score;
  final String gameMode;
  final String category;
  final DateTime timestamp;
  
  ScoreModel({
    required this.id,
    required this.playerName,
    required this.score,
    required this.gameMode,
    required this.category,
    required this.timestamp,
  });
  
  factory ScoreModel.fromMap(Map<String, dynamic> map, String docId) {
    return ScoreModel(
      id: docId,
      playerName: map['playerName'] ?? 'Anonim',
      score: map['score'] ?? 0,
      gameMode: map['gameMode'] ?? 'classic',
      category: map['category'] ?? 'Tümü',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'score': score,
      'gameMode': gameMode,
      'category': category,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}