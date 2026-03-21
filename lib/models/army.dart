class Army {
  final int? id;
  final int? gameId;
  final String name;
  final bool visible;

  Army({
    this.id,
    required this.gameId,
    required this.name,
    this.visible = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'game_id': gameId, // ⚠ usar game_id
      'name': name,
      'visible': visible ? 1 : 0,
    };
  }

  factory Army.fromMap(Map<String, dynamic> map) {
    return Army(
      id: map['id'] as int?,
      gameId: map['game_id'] as int?, // ⚠ usar game_id
      name: map['name'] as String,
      visible: (map['visible'] ?? 0) == 1,
    );
  }
}
