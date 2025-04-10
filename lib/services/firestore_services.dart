// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final _db = FirebaseFirestore.instance;

//   Future<void> saveScore(String playerName, int score) async {
//     try {
//       await _db.collection('scores').doc(playerName).set({
//         'name': playerName,
//         'score': score,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print("Firestore error: $e");
//     }
//   }
// }
