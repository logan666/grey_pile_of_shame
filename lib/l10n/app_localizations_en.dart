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

  @override
  String get newMiniatureTitle => 'New Miniature';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get changeAllStatusesTooltip => 'Change status for all';

  @override
  String get unknownStatus => 'Unknown';

  @override
  String get finishedStatusCheck => 'Finished';

  @override
  String get noUnitsYet => 'No units yet';

  @override
  String get uncategorized => 'No category';

  @override
  String unitCreated(Object unitName) {
    return 'Unit \"$unitName\" created successfully';
  }

  @override
  String unitUpdated(Object unitName) {
    return 'Unit \"$unitName\" updated successfully';
  }

  @override
  String unitDeleted(Object unitName) {
    return 'Unit \"$unitName\" deleted successfully';
  }

  @override
  String get addUnit => 'Add Unit';

  @override
  String get ofTotal => 'of';

  @override
  String get category => 'Category';

  @override
  String get name => 'Name';

  @override
  String get newUnit => 'New Unit';

  @override
  String get editUnit => 'Edit Unit';

  @override
  String get army => 'Army';

  @override
  String get selectOption => 'Choose...';

  @override
  String get paintingDifficulty => 'Painting difficulty:';

  @override
  String get points => 'Points';

  @override
  String get price => 'Price (€)';

  @override
  String get purchaseDate => 'Purchase date:';

  @override
  String get finishDate => 'Completion date:';

  @override
  String get notes => 'Notes';

  @override
  String get requiredField => 'Required field';

  @override
  String get integerRequired => 'Must be an integer number';

  @override
  String get validPriceRequired => 'Must be a valid price';

  @override
  String get deleteUnitTitle => 'Delete unit';

  @override
  String deleteUnitConfirm(Object name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get newGameSystem => 'Nuevo Sistema de Juego';

  @override
  String get gameSystemName => 'Nombre del sistema de juego';

  @override
  String get gameNameRequired => 'El nombre no puede estar vacío';

  @override
  String get gameSavedSuccessfully => 'Juego guardado correctamente';
}
