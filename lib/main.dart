import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/dao/parametric_dao.dart';
import 'package:grey_pile_of_shame/l10n/app_localizations.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final paramDao = ParametricDao();
  await paramDao.insertDefaultDataIfNeeded();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grey Pile of Shame',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'), // idioma por defecto
    );
  }
}
