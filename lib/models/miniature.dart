class Miniature {
  final int? id;
  final int unitId;
  final String description;
  int paintingStatus;

  Miniature({
    this.id,
    required this.unitId,
    required this.description,
    this.paintingStatus = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit_id': unitId,
      'description': description,
      'painting_status': paintingStatus,
    };
  }

  factory Miniature.fromMap(Map<String, dynamic> map) {
    return Miniature(
      id: map['id'] as int?,
      unitId: map['unit_id'] as int,
      description: map['description'] as String,
      paintingStatus: map['painting_status'] as int? ?? 1,
    );
  }
}
