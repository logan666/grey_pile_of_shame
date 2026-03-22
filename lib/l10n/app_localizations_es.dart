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
  String get delete => 'Borrar';

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
