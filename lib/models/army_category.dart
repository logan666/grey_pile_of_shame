class ArmyCategory {
  final int? id;
  final int gameId;
  final String name;
  final String? icon;

  ArmyCategory({this.id, required this.gameId, required this.name, this.icon});

  factory ArmyCategory.fromMap(Map<String, dynamic> map) {
    return ArmyCategory(
      id: map['id'] as int?,
      gameId: map['game_id'] as int,
      name: map['name'] as String,
      icon: map['icon'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'game_id': gameId, 'name': name, 'icon': icon};
  }
}
