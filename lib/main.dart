import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/service_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "EG"),
      ],
      locale: Locale("ar", "EG"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown,
        accentColor: Color(0xff90623b),
        brightness: Brightness.light,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.grey[600])),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ServiceDetails(),
    );
  }
}
