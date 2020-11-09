import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'utils/localization.dart';
import 'screens/sign_in.dart';
import './providers/dark_theme_provider.dart';
import './theme/theme_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            title: 'This is very basic app screen',
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('ko', 'KR'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supportedLocales) {
              if (locale == null) {
                debugPrint('locale language is null');
                return supportedLocales.first;
              }
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: AppTheme.themeData(themeChangeProvider.darkTheme, context),
            home: SignIn(),
          );
        },
      ),
    );
  }
}
