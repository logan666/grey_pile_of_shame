class Army {
  final int? id;
  final int? gameId;
  final String name;
  final String? description;

  Army({this.id, required this.gameId, required this.name, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameId': gameId,
      'name': name,
      'description': description,
    };
  }

  factory Army.fromMap(Map<String, dynamic> map) {
    return Army(
      id: map['id'] as int?,
      gameId: map['game_id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String?,
    );
  }
}
