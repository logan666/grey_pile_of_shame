// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Grey Pile of Shame';

  @override
  String get welcome => 'Willkommen!';

  @override
  String get noGamesVisible => 'Es gibt keine Spiele mit sichtbaren Armeen.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get add => 'Hinzufügen';

  @override
  String get delete => 'Löschen';

  @override
  String get appBarTitle => 'Spiele und Armeen';

  @override
  String get newGame => 'Neues Spiel';

  @override
  String get editGame => 'Spiel bearbeiten';

  @override
  String get gameName => 'Spielname';

  @override
  String get confirmDeleteGameTitle => 'Löschbestätigung';

  @override
  String confirmDeleteGameContent(Object gameName) {
    return 'Möchtest du das Spiel \"$gameName\" und alle zugehörigen Armeen löschen?';
  }

  @override
  String get newArmy => 'Neue Armee';

  @override
  String get editArmy => 'Armee bearbeiten';

  @override
  String get armyName => 'Armeename';

  @override
  String get visualStyle => 'Visueller Stil';

  @override
  String get logo => 'Logo';

  @override
  String get addArmy => 'Armee hinzufügen';

  @override
  String get saveArmy => 'Speichern';

  @override
  String get confirmDeleteArmyTitle => 'Löschbestätigung';

  @override
  String confirmDeleteArmyContent(Object armyName) {
    return 'Möchtest du die Armee \"$armyName\" löschen?';
  }

  @override
  String get categorySettingsTitle => 'Kategorieeinstellungen';

  @override
  String get newCategory => 'Neue Kategorie';

  @override
  String get editCategory => 'Kategorie bearbeiten';

  @override
  String get deleteCategoryTitle => 'Kategorie löschen';

  @override
  String deleteCategoryContent(Object categoryName) {
    return 'Möchtest du \"$categoryName\" wirklich löschen?';
  }

  @override
  String get categoryNameLabel => 'Name';

  @override
  String get categoryIconLabel => 'Symbol';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get armiesTitle => 'Armeen';

  @override
  String get armiesSubtitle => 'Armeen anzeigen oder ausblenden';

  @override
  String get categoriesTitle => 'Kategorien';

  @override
  String get categoriesSubtitle => 'Einheitenkategorien verwalten';

  @override
  String get newMiniatureTitle => 'Neue Miniatur';

  @override
  String get descriptionLabel => 'Beschreibung';

  @override
  String get changeAllStatusesTooltip => 'Status für alle ändern';

  @override
  String get unknownStatus => 'Unbekannt';

  @override
  String get finishedStatusCheck => 'Fertiggestellt';

  @override
  String get noUnitsYet => 'Noch keine Einheiten';

  @override
  String get uncategorized => 'Ohne Kategorie';

  @override
  String unitCreated(Object unitName) {
    return 'Einheit \"$unitName\" erfolgreich erstellt';
  }

  @override
  String unitUpdated(Object unitName) {
    return 'Einheit \"$unitName\" erfolgreich aktualisiert';
  }

  @override
  String unitDeleted(Object unitName) {
    return 'Einheit \"$unitName\" erfolgreich gelöscht';
  }

  @override
  String get addUnit => 'Einheit hinzufügen';

  @override
  String get ofTotal => 'von';

  @override
  String get category => 'Kategorie';

  @override
  String get name => 'Name';

  @override
  String get newUnit => 'Neue Einheit';

  @override
  String get editUnit => 'Einheit bearbeiten';

  @override
  String get army => 'Armee';

  @override
  String get selectOption => 'Auswählen...';

  @override
  String get paintingDifficulty => 'Bemalungsaufwand:';

  @override
  String get points => 'Punkte';

  @override
  String get price => 'Preis (€)';

  @override
  String get purchaseDate => 'Kaufdatum:';

  @override
  String get finishDate => 'Fertigstellungsdatum:';

  @override
  String get notes => 'Notizen';

  @override
  String get requiredField => 'Pflichtfeld';

  @override
  String get integerRequired => 'Muss eine ganze Zahl sein';

  @override
  String get validPriceRequired => 'Muss ein gültiger Preis sein';

  @override
  String get deleteUnitTitle => 'Einheit löschen';

  @override
  String deleteUnitConfirm(Object name) {
    return 'Möchtest du \"$name\" wirklich löschen?';
  }
}
