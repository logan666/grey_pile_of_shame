// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Grey Pile of Shame';

  @override
  String get welcome => 'Bienvenue !';

  @override
  String get noGamesVisible => 'Il n\'y a aucun jeu avec des armées visibles.';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get add => 'Ajouter';

  @override
  String get delete => 'Supprimer';

  @override
  String get appBarTitle => 'Jeux et armées';

  @override
  String get newGame => 'Nouveau jeu';

  @override
  String get editGame => 'Modifier le jeu';

  @override
  String get gameName => 'Nom du jeu';

  @override
  String get confirmDeleteGameTitle => 'Confirmation de suppression';

  @override
  String confirmDeleteGameContent(Object gameName) {
    return 'Voulez-vous supprimer le jeu \"$gameName\" et toutes ses armées ?';
  }

  @override
  String get newArmy => 'Nouvelle armée';

  @override
  String get editArmy => 'Modifier l\'armée';

  @override
  String get armyName => 'Nom de l\'armée';

  @override
  String get visualStyle => 'Style visuel';

  @override
  String get logo => 'Logo';

  @override
  String get addArmy => 'Ajouter une armée';

  @override
  String get saveArmy => 'Enregistrer';

  @override
  String get confirmDeleteArmyTitle => 'Confirmation de suppression';

  @override
  String confirmDeleteArmyContent(Object armyName) {
    return 'Voulez-vous supprimer l\'armée \"$armyName\" ?';
  }

  @override
  String get categorySettingsTitle => 'Paramètres des catégories';

  @override
  String get newCategory => 'Nouvelle catégorie';

  @override
  String get editCategory => 'Modifier la catégorie';

  @override
  String get deleteCategoryTitle => 'Supprimer la catégorie';

  @override
  String deleteCategoryContent(Object categoryName) {
    return 'Êtes-vous sûr de vouloir supprimer \"$categoryName\" ?';
  }

  @override
  String get categoryNameLabel => 'Nom';

  @override
  String get categoryIconLabel => 'Icône';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get armiesTitle => 'Armées';

  @override
  String get armiesSubtitle => 'Afficher ou masquer les armées';

  @override
  String get categoriesTitle => 'Catégories';

  @override
  String get categoriesSubtitle => 'Gérer les catégories d\'unités';

  @override
  String get newMiniatureTitle => 'Nouvelle figurine';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get changeAllStatusesTooltip => 'Changer le statut pour tous';

  @override
  String get unknownStatus => 'Inconnu';

  @override
  String get finishedStatusCheck => 'Terminé';

  @override
  String get noUnitsYet => 'Aucune unité pour le moment';

  @override
  String get uncategorized => 'Sans catégorie';

  @override
  String unitCreated(Object unitName) {
    return 'Unité \"$unitName\" créée avec succès';
  }

  @override
  String unitUpdated(Object unitName) {
    return 'Unité \"$unitName\" mise à jour avec succès';
  }

  @override
  String unitDeleted(Object unitName) {
    return 'Unité \"$unitName\" supprimée avec succès';
  }

  @override
  String get addUnit => 'Ajouter une unité';

  @override
  String get ofTotal => 'sur';

  @override
  String get category => 'Catégorie';

  @override
  String get name => 'Nom';

  @override
  String get newUnit => 'Nouvelle unité';

  @override
  String get editUnit => 'Modifier l\'unité';

  @override
  String get army => 'Armée';

  @override
  String get selectOption => 'Choisir...';

  @override
  String get paintingDifficulty => 'Difficulté de peinture :';

  @override
  String get points => 'Points';

  @override
  String get price => 'Prix (€)';

  @override
  String get purchaseDate => 'Date d\'achat :';

  @override
  String get finishDate => 'Date d\'achèvement :';

  @override
  String get notes => 'Notes';

  @override
  String get requiredField => 'Champ obligatoire';

  @override
  String get integerRequired => 'Doit être un nombre entier';

  @override
  String get validPriceRequired => 'Doit être un prix valide';

  @override
  String get deleteUnitTitle => 'Supprimer l\'unité';

  @override
  String deleteUnitConfirm(Object name) {
    return 'Voulez-vous vraiment supprimer \"$name\" ?';
  }
}
