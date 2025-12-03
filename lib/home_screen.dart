import 'package:flutter/material.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeTab(),
      const PharmacyTab(),
      const SettingsTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MedFinder'),
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: kMainColor),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/medfinder_logo.png'),
                  ),
                  const SizedBox(width: 10),
                  const Text('MedFinder',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() => index = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_pharmacy),
              title: const Text('Pharmacies'),
              onTap: () {
                Navigator.pop(context);
                setState(() => index = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Medicines'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MedicinesGrid()),
                );
              },
            ),
          ],
        ),
      ),

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: kMainColor,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_pharmacy), label: "Pharmacies"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

/// ---------------- HOME TAB (with distance slider) ----------------
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  double _distance = 5; // km

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/medfinder_logo.png', height: 100),
            const SizedBox(height: 12),
            const Text(
              "Search medicines & pharmacies",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              "Search distance: ${_distance.toStringAsFixed(0)} km",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              min: 1,
              max: 30,
              value: _distance,
              activeColor: kMainColor,
              onChanged: (v) {
                setState(() => _distance = v);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- PHARMACIES ----------------
class Pharmacy {
  final String name;
  final String area;
  Pharmacy(this.name, this.area);
}

class PharmacyTab extends StatelessWidget {
  const PharmacyTab({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      Pharmacy("Shifa Pharmacy", "Ainkawa"),
      Pharmacy("LifeCare", "60m Road"),
      Pharmacy("City Health", "Italian Village"),
    ];

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (c, i) {
        return ListTile(
          leading: const Icon(Icons.local_pharmacy, color: kMainColor),
          title: Text(list[i].name),
          subtitle: Text(list[i].area),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PharmacyDetails(p: list[i]),
              ),
            );
          },
        );
      },
    );
  }
}

class PharmacyDetails extends StatelessWidget {
  final Pharmacy p;
  const PharmacyDetails({super.key, required this.p});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(p.name), backgroundColor: kMainColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("Located in: ${p.area}"),
      ),
    );
  }
}

/// ---------------- GRIDVIEW (tap shows availability) ----------------
class MedicinesGrid extends StatelessWidget {
  const MedicinesGrid({super.key});

  String _whereAvailable(String med) {
    switch (med) {
      case "Paracetamol":
        return "Shifa Pharmacy, LifeCare";
      case "Ibuprofen":
        return "LifeCare, City Health";
      case "Vitamin C":
        return "Shifa Pharmacy";
      case "Amoxicillin":
        return "City Health Pharmacy";
      case "Cetirizine":
        return "Shifa Pharmacy, City Health";
      case "Omeprazole":
        return "LifeCare Pharmacy";
      default:
        return "Shifa Pharmacy, LifeCare, City Health";
    }
  }

  @override
  Widget build(BuildContext context) {
    final meds = [
      "Paracetamol",
      "Ibuprofen",
      "Vitamin C",
      "Amoxicillin",
      "Cetirizine",
      "Omeprazole"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: meds.map((m) {
          return Card(
            child: InkWell(
              onTap: () {
                final places = _whereAvailable(m);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(m),
                    content: Text("Available at:\n$places"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Center(child: Text(m)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// ---------------- SETTINGS (Dark mode removed) ----------------
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool noti = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text("Notifications"),
          value: noti,
          onChanged: (v) => setState(() => noti = v),
        ),
      ],
    );
  }
}
