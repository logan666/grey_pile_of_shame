// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Grey Pile of Shame';

  @override
  String get welcome => 'Welcome!';

  @override
  String get noGamesVisible => 'There are no games with visible armies';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get appBarTitle => 'Games and Armies';

  @override
  String get newGame => 'New Game';

  @override
  String get editGame => 'Edit Game';

  @override
  String get gameName => 'Game Name';

  @override
  String get confirmDeleteGameTitle => 'Delete Confirmation';

  @override
  String confirmDeleteGameContent(Object gameName) {
    return 'Do you want to delete the game \"$gameName\" and all its armies?';
  }

  @override
  String get newArmy => 'New Army';

  @override
  String get editArmy => 'Edit Army';

  @override
  String get armyName => 'Army Name';

  @override
  String get visualStyle => 'Visual Style';

  @override
  String get logo => 'Logo';

  @override
  String get addArmy => 'Add Army';

  @override
  String get saveArmy => 'Save';

  @override
  String get confirmDeleteArmyTitle => 'Delete Confirmation';

  @override
  String confirmDeleteArmyContent(Object armyName) {
    return 'Do you want to delete the army \"$armyName\"?';
  }

  @override
  String get categorySettingsTitle => 'Category Settings';

  @override
  String get newCategory => 'New Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get deleteCategoryTitle => 'Delete Category';

  @override
  String deleteCategoryContent(Object categoryName) {
    return 'Are you sure you want to delete \"$categoryName\"?';
  }

  @override
  String get categoryNameLabel => 'Name';

  @override
  String get categoryIconLabel => 'Icon';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get armiesTitle => 'Armies';

  @override
  String get armiesSubtitle => 'Show or hide armies';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get categoriesSubtitle => 'Manage unit categories';
}
