// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Grey Pile of Shame';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get noGamesVisible => 'No hay juegos con ejércitos visibles';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get add => 'Agregar';

  @override
  String get appBarTitle => 'Juegos y Ejércitos';

  @override
  String get newGame => 'Nuevo juego';

  @override
  String get editGame => 'Editar juego';

  @override
  String get gameName => 'Nombre del juego';

  @override
  String get confirmDeleteGameTitle => 'Confirmar borrado';

  @override
  String confirmDeleteGameContent(Object gameName) {
    return '¿Deseas borrar el juego \"$gameName\" y todos sus ejércitos?';
  }

  @override
  String get delete => 'Borrar';

  @override
  String get newArmy => 'Nuevo ejército';

  @override
  String get editArmy => 'Editar ejército';

  @override
  String get armyName => 'Nombre del ejército';

  @override
  String get visualStyle => 'Estilo visual';

  @override
  String get logo => 'Logo';

  @override
  String get addArmy => 'Agregar ejército';

  @override
  String get saveArmy => 'Guardar';

  @override
  String get confirmDeleteArmyTitle => 'Confirmar borrado';

  @override
  String confirmDeleteArmyContent(Object armyName) {
    return '¿Deseas borrar el ejército \"$armyName\"?';
  }
}
