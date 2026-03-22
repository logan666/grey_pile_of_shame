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
  String get welcome => '¡Bienvenido!';

  @override
  String get noGamesVisible => 'No hay juegos con ejércitos visibles.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get add => 'Añadir';

  @override
  String get delete => 'Eliminar';

  @override
  String get appBarTitle => 'Juegos y Ejércitos';

  @override
  String get newGame => 'Nuevo Juego';

  @override
  String get editGame => 'Editar Juego';

  @override
  String get gameName => 'Nombre del juego';

  @override
  String get confirmDeleteGameTitle => 'Confirmación de borrado';

  @override
  String confirmDeleteGameContent(Object gameName) {
    return '¿Quieres eliminar el juego \"$gameName\" y todos sus ejércitos?';
  }

  @override
  String get newArmy => 'Nuevo Ejército';

  @override
  String get editArmy => 'Editar Ejército';

  @override
  String get armyName => 'Nombre del ejército';

  @override
  String get visualStyle => 'Estilo visual';

  @override
  String get logo => 'Logo';

  @override
  String get addArmy => 'Añadir ejército';

  @override
  String get saveArmy => 'Guardar';

  @override
  String get confirmDeleteArmyTitle => 'Confirmación de borrado';

  @override
  String confirmDeleteArmyContent(Object armyName) {
    return '¿Quieres eliminar el ejército \"$armyName\"?';
  }

  @override
  String get categorySettingsTitle => 'Configuración de categorías';

  @override
  String get newCategory => 'Nueva categoría';

  @override
  String get editCategory => 'Editar categoría';

  @override
  String get deleteCategoryTitle => 'Eliminar categoría';

  @override
  String deleteCategoryContent(Object categoryName) {
    return '¿Seguro que quieres eliminar \"$categoryName\"?';
  }

  @override
  String get categoryNameLabel => 'Nombre';

  @override
  String get categoryIconLabel => 'Icono';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get armiesTitle => 'Ejércitos';

  @override
  String get armiesSubtitle => 'Mostrar u ocultar ejércitos';

  @override
  String get categoriesTitle => 'Categorías';

  @override
  String get categoriesSubtitle => 'Gestionar categorías de unidades';

  @override
  String get newMiniatureTitle => 'Nueva miniatura';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get changeAllStatusesTooltip => 'Cambiar estado para todos';

  @override
  String get unknownStatus => 'Desconocido';

  @override
  String get finishedStatusCheck => 'Finalizado';

  @override
  String get noUnitsYet => 'Aún no hay unidades';

  @override
  String get uncategorized => 'Sin categoría';

  @override
  String unitCreated(Object unitName) {
    return 'Unidad \"$unitName\" creada correctamente';
  }

  @override
  String unitUpdated(Object unitName) {
    return 'Unidad \"$unitName\" actualizada correctamente';
  }

  @override
  String unitDeleted(Object unitName) {
    return 'Unidad \"$unitName\" eliminada correctamente';
  }

  @override
  String get addUnit => 'Añadir unidad';

  @override
  String get ofTotal => 'de';

  @override
  String get category => 'Categoría';

  @override
  String get name => 'Nombre';

  @override
  String get newUnit => 'Nueva unidad';

  @override
  String get editUnit => 'Editar unidad';

  @override
  String get army => 'Ejército';

  @override
  String get selectOption => 'Seleccione...';

  @override
  String get paintingDifficulty => 'Complejidad de pintado:';

  @override
  String get points => 'Puntos';

  @override
  String get price => 'Precio (€)';

  @override
  String get purchaseDate => 'Fecha de compra:';

  @override
  String get finishDate => 'Fecha de finalización:';

  @override
  String get notes => 'Observaciones';

  @override
  String get requiredField => 'Campo obligatorio';

  @override
  String get integerRequired => 'Debe ser un número entero';

  @override
  String get validPriceRequired => 'Debe ser un precio válido';

  @override
  String get deleteUnitTitle => 'Eliminar unidad';

  @override
  String deleteUnitConfirm(Object name) {
    return '¿Seguro que quieres eliminar \"$name\"?';
  }

  @override
  String get paintingStatusSettingsTitle => 'Estados de Pintura';

  @override
  String get paintingStatusSettingsSubtitle => 'Administra los estados de pintura';

  @override
  String get newPaintingStatus => 'Nuevo Estado de Pintura';

  @override
  String get editPaintingStatus => 'Editar Estado de Pintura';

  @override
  String get deletePaintingStatusTitle => 'Eliminar Estado de Pintura';

  @override
  String deletePaintingStatusContent(Object name) {
    return '¿Seguro que quieres eliminar el estado de pintura \"$name\"?';
  }

  @override
  String get statusNameLabel => 'Nombre';

  @override
  String get statusColorLabel => 'Color';

  @override
  String get statusOrderLabel => 'Orden';
}
