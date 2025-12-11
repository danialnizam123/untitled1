import 'package:flutter/material.dart';

class MedicinesPage extends StatelessWidget {
  const MedicinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final medicines = [
      'Paracetamol',
      'Ibuprofen',
      'Vitamin C',
      'Amoxicillin',
      'Cetirizine',
      'Omeprazole',
    ];

    final availability = {
      'Paracetamol': 'Shifa Pharmacy, LifeCare Pharmacy',
      'Ibuprofen': 'LifeCare Pharmacy',
      'Vitamin C': 'Shifa Pharmacy',
      'Amoxicillin': 'City Health Pharmacy',
      'Cetirizine': 'Shifa Pharmacy, City Health Pharmacy',
      'Omeprazole': 'All pharmacies',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: medicines.map((name) {
            return Card(
              child: InkWell(
                onTap: () {
                  final info = availability[name] ?? 'No data';
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(name),
                      content: Text('Available at: $info'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
