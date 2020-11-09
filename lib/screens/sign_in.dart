import 'package:flutter/material.dart';
import '../utils/localization.dart';
import 'package:provider/provider.dart';
import '../providers/dark_theme_provider.dart';

class SignIn extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('SIGN_IN'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '로그인',
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Switch(
              activeColor: Colors.blue,
              inactiveTrackColor: Colors.lightBlueAccent,
              value: themeChange.darkTheme,
              onChanged: (bool value) {
                themeChange.darkTheme = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
