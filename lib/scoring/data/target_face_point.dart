class TargetFacePoint {
  final String id;
  final String color;
  final int value;
  TargetFacePoint({
    this.id = '',
    this.color = '',
    this.value = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color,
      'value': value,
    };
  }
}
