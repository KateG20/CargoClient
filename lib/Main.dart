import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/EntryPage.dart';

void main() {
  runApp(MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('ru')],
      home: EntryPage()));
}
