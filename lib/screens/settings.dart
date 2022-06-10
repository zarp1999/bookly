import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/constants.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text(
          "Тохиргоо",
          style: TextStyle(),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Divider(),
            ListTile(
              title: Text(
                "Харанхуй горим",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: Text("Харанхуй горим асаах"),
              trailing: Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => CupertinoSwitch(
                  onChanged: (val) {
                    notifier.toggleTheme();
                  },
                  value: notifier.dark,
                  activeColor: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
