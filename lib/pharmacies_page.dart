import 'package:flutter/material.dart';

class PharmaciesPage extends StatelessWidget {
  const PharmaciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacies = [
      {
        'name': 'Shifa Pharmacy',
        'area': 'Ainkawa',
        'address': 'Ainkawa, Erbil, Iraq',
        'map': 'https://maps.google.com/?q=Shifa+Pharmacy+Ainkawa',
      },
      {
        'name': 'LifeCare Pharmacy',
        'area': '60m Road',
        'address': '60m Road, Erbil, Iraq',
        'map': 'https://maps.google.com/?q=LifeCare+Pharmacy+Erbil',
      },
      {
        'name': 'City Health Pharmacy',
        'area': 'Italian Village',
        'address': 'Italian Village, Erbil, Iraq',
        'map': 'https://maps.google.com/?q=City+Health+Pharmacy+Erbil',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacies'),
      ),
      body: ListView.builder(
        itemCount: pharmacies.length,
        itemBuilder: (context, index) {
          final p = pharmacies[index];
          return ListTile(
            leading: const Icon(Icons.local_pharmacy),
            title: Text(p['name']!),
            subtitle: Text(p['area']!),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(p['name']!),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location: ${p['address']}'),
                      const SizedBox(height: 8),
                      const Text('Google Maps link:'),
                      Text(
                        p['map']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
