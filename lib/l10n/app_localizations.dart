import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Grey Pile of Shame'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @noGamesVisible.
  ///
  /// In en, this message translates to:
  /// **'There are no games with visible armies'**
  String get noGamesVisible;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Games and Armies'**
  String get appBarTitle;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @editGame.
  ///
  /// In en, this message translates to:
  /// **'Edit Game'**
  String get editGame;

  /// No description provided for @gameName.
  ///
  /// In en, this message translates to:
  /// **'Game Name'**
  String get gameName;

  /// No description provided for @confirmDeleteGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get confirmDeleteGameTitle;

  /// No description provided for @confirmDeleteGameContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the game \"{gameName}\" and all its armies?'**
  String confirmDeleteGameContent(Object gameName);

  /// No description provided for @newArmy.
  ///
  /// In en, this message translates to:
  /// **'New Army'**
  String get newArmy;

  /// No description provided for @editArmy.
  ///
  /// In en, this message translates to:
  /// **'Edit Army'**
  String get editArmy;

  /// No description provided for @armyName.
  ///
  /// In en, this message translates to:
  /// **'Army Name'**
  String get armyName;

  /// No description provided for @visualStyle.
  ///
  /// In en, this message translates to:
  /// **'Visual Style'**
  String get visualStyle;

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get logo;

  /// No description provided for @addArmy.
  ///
  /// In en, this message translates to:
  /// **'Add Army'**
  String get addArmy;

  /// No description provided for @saveArmy.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveArmy;

  /// No description provided for @confirmDeleteArmyTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get confirmDeleteArmyTitle;

  /// No description provided for @confirmDeleteArmyContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the army \"{armyName}\"?'**
  String confirmDeleteArmyContent(Object armyName);

  /// No description provided for @categorySettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Category Settings'**
  String get categorySettingsTitle;

  /// No description provided for @newCategory.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get newCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @deleteCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategoryTitle;

  /// No description provided for @deleteCategoryContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{categoryName}\"?'**
  String deleteCategoryContent(Object categoryName);

  /// No description provided for @categoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get categoryNameLabel;

  /// No description provided for @categoryIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get categoryIconLabel;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @armiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Armies'**
  String get armiesTitle;

  /// No description provided for @armiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show or hide armies'**
  String get armiesSubtitle;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @categoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage unit categories'**
  String get categoriesSubtitle;

  /// No description provided for @newMiniatureTitle.
  ///
  /// In en, this message translates to:
  /// **'New Miniature'**
  String get newMiniatureTitle;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @changeAllStatusesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change status for all'**
  String get changeAllStatusesTooltip;

  /// No description provided for @unknownStatus.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownStatus;

  /// No description provided for @finishedStatusCheck.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finishedStatusCheck;

  /// No description provided for @noUnitsYet.
  ///
  /// In en, this message translates to:
  /// **'No units yet'**
  String get noUnitsYet;

  /// No description provided for @uncategorized.
  ///
  /// In en, this message translates to:
  /// **'No category'**
  String get uncategorized;

  /// No description provided for @unitCreated.
  ///
  /// In en, this message translates to:
  /// **'Unit \"{unitName}\" created successfully'**
  String unitCreated(Object unitName);

  /// No description provided for @unitUpdated.
  ///
  /// In en, this message translates to:
  /// **'Unit \"{unitName}\" updated successfully'**
  String unitUpdated(Object unitName);

  /// No description provided for @unitDeleted.
  ///
  /// In en, this message translates to:
  /// **'Unit \"{unitName}\" deleted successfully'**
  String unitDeleted(Object unitName);

  /// No description provided for @addUnit.
  ///
  /// In en, this message translates to:
  /// **'Add Unit'**
  String get addUnit;

  /// No description provided for @ofTotal.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofTotal;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @newUnit.
  ///
  /// In en, this message translates to:
  /// **'New Unit'**
  String get newUnit;

  /// No description provided for @editUnit.
  ///
  /// In en, this message translates to:
  /// **'Edit Unit'**
  String get editUnit;

  /// No description provided for @army.
  ///
  /// In en, this message translates to:
  /// **'Army'**
  String get army;

  /// No description provided for @selectOption.
  ///
  /// In en, this message translates to:
  /// **'Choose...'**
  String get selectOption;

  /// No description provided for @paintingDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Painting difficulty:'**
  String get paintingDifficulty;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price (€)'**
  String get price;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date:'**
  String get purchaseDate;

  /// No description provided for @finishDate.
  ///
  /// In en, this message translates to:
  /// **'Completion date:'**
  String get finishDate;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredField;

  /// No description provided for @integerRequired.
  ///
  /// In en, this message translates to:
  /// **'Must be an integer number'**
  String get integerRequired;

  /// No description provided for @validPriceRequired.
  ///
  /// In en, this message translates to:
  /// **'Must be a valid price'**
  String get validPriceRequired;

  /// No description provided for @deleteUnitTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete unit'**
  String get deleteUnitTitle;

  /// No description provided for @deleteUnitConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteUnitConfirm(Object name);

  /// No description provided for @newGameSystem.
  ///
  /// In en, this message translates to:
  /// **'Nuevo Sistema de Juego'**
  String get newGameSystem;

  /// No description provided for @gameSystemName.
  ///
  /// In en, this message translates to:
  /// **'Nombre del sistema de juego'**
  String get gameSystemName;

  /// No description provided for @gameNameRequired.
  ///
  /// In en, this message translates to:
  /// **'El nombre no puede estar vacío'**
  String get gameNameRequired;

  /// No description provided for @gameSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Juego guardado correctamente'**
  String get gameSavedSuccessfully;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
