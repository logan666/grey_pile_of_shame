import 'package:grey_pile_of_shame/models/army_category.dart';

class Game {
  final int? id;
  final String name;
  final String? logo;
  final List<ArmyCategory>? categories;

  Game({this.id, required this.name, this.logo, this.categories});

  factory Game.fromMap(
    Map<String, dynamic> map, [
    List<ArmyCategory>? categories,
  ]) {
    return Game(
      id: map['id'] as int?,
      name: map['name'] as String,
      logo: map['logo'] as String?,
      categories: categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'logo': logo};
  }
}
