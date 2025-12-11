import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double resultDistance = 5;
  bool notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Search distance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Distance: ${resultDistance.toStringAsFixed(0)} km'),
            Slider(
              value: resultDistance,
              min: 1,
              max: 20,
              divisions: 19,
              label: '${resultDistance.toStringAsFixed(0)} km',
              onChanged: (value) {
                setState(() {
                  resultDistance = value;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Enable notifications'),
              value: notificationsOn,
              onChanged: (value) {
                setState(() {
                  notificationsOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
