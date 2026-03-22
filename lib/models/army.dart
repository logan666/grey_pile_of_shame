class Army {
  final int? id;
  final int? gameId;
  final String name;
  final bool visible;
  final String? image;

  Army({
    this.id,
    required this.gameId,
    required this.name,
    this.visible = false,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'game_id': gameId,
      'name': name,
      'visible': visible ? 1 : 0,
      'image': image,
    };
  }

  factory Army.fromMap(Map<String, dynamic> map) {
    return Army(
      id: map['id'] as int?,
      gameId: map['game_id'] as int?,
      name: map['name'] as String,
      visible: (map['visible'] ?? 0) == 1,
      image: map['image'],
    );
  }
}
