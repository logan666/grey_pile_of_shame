class Unit {
  final int? id;
  final int? armyId; // referencia a Army
  final String name;
  final int? roleId; // referencia a tabla roles
  final int? points; // valor en puntos
  final double? price; // precio en euros
  final int paintingDifficulty; // 1-10, número de miniaturas por tiempo
  final DateTime? finishedAt; // fecha de finalización
  final DateTime? purchasedAt; // fecha de compra
  final String? notes; // observaciones

  Unit({
    this.id,
    required this.armyId,
    required this.name,
    this.roleId,
    this.points,
    this.price,
    this.paintingDifficulty = 1,
    this.finishedAt,
    this.purchasedAt,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'army_id': armyId,
      'name': name,
      'role_id': roleId,
      'points': points,
      'price': price,
      'painting_difficulty': paintingDifficulty,
      'finished_at': finishedAt?.toIso8601String(),
      'purchased_at': purchasedAt?.toIso8601String(),
      'notes': notes,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'] as int?,
      armyId: map['army_id'] as int,
      name: map['name'] as String,
      roleId: map['role_id'] as int,
      points: map['points'] as int? ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      paintingDifficulty: map['painting_difficulty'] as int? ?? 1,
      finishedAt: map['finished_at'] != null
          ? DateTime.parse(map['finished_at'] as String)
          : null,
      purchasedAt: map['purchased_at'] != null
          ? DateTime.parse(map['purchased_at'] as String)
          : null,
      notes: map['notes'] as String?,
    );
  }
}
