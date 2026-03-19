class Game {
  final int? id;
  final String name;

  Game({this.id, required this.name});

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(id: map['id'] as int?, name: map['name'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
