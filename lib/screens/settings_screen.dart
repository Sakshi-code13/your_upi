import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const SettingsScreen({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isAppLockEnabled = false;

  @override
  void initState() {
    super.initState();
    isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
  }

  void _toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
    widget.onThemeChanged(value);
  }

  void _toggleAppLock(bool value) {
    setState(() {
      isAppLockEnabled = value;
    });
    // TODO: Implement app lock with fingerprint/PIN
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: isDarkMode,
            onChanged: _toggleTheme,
          ),
          SwitchListTile(
            title: Text('Enable App Lock (Fingerprint/PIN)'),
            value: isAppLockEnabled,
            onChanged: _toggleAppLock,
          ),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Privacy Policy'),
                  content: SingleChildScrollView(
                    child: Text(
                      'YOUR UPI stores all data locally on your device. No data is shared externally without your consent. '
                      'The app does not process payments directly and redirects to official UPI apps for transactions. '
                      'Your privacy and security are our top priorities.',
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
