import 'package:archery_club/scoring/data/target_face.dart';

class Skoring {
  final String name;
  final int distance;
  final String bow;
  final int arrow;
  final int round;
  final String targetFace;
  final List<dynamic> scors;
  Skoring({
    this.name = '',
    this.distance = 0,
    this.bow = '',
    this.arrow = 0,
    this.round = 0,
    required this.targetFace,
    this.scors = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'distance': distance,
      'bow': bow,
      'arrow': arrow,
      'round': round,
      'targetFace': targetFace,
      'scors': scors,
    };
  }
}
