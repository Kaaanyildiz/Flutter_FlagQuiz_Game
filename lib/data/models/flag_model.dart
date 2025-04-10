import '../../domain/entities/flag.dart';

class FlagModel extends Flag {
  FlagModel({required super.name, required super.imageUrl});

  factory FlagModel.fromMap(MapEntry<String, String> entry) {
    return FlagModel(name: entry.key, imageUrl: entry.value);
  }
}
