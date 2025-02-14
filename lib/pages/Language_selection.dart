import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:feed_the_needy/main.dart';
import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              _changeLanguage(context, const Locale('en'));
            },
          ),
          ListTile(
            title: Text('Tamil(தமிழ்)'),
            onTap: () {
              _changeLanguage(context, const Locale('ta'));
            },
          ),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) {
    MyApp.setLocale(context, locale);
    Navigator.pop(context); // Close the language selection screen
  }
}
