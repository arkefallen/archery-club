import 'package:archery_club/scoring/data/target_face_point.dart';

class TargetFace {
  final String id;
  final String name;
  final String imageUrl;
  final int heightInCm;
  final int widthInCm;
  final List point;
  TargetFace({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
    this.heightInCm = 0,
    this.widthInCm = 0,
    this.point = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'heightInCm': heightInCm,
      'widthInCm': widthInCm,
      'point': point,
    };
  }
}
