import 'package:flutter/material.dart';
import '../models/phone_model.dart';

class PhoneDetailScreen extends StatelessWidget {
  final Phone phone;

  const PhoneDetailScreen({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(phone.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                phone.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: Icon(Icons.broken_image, size: 80)),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // NAME
            Text(
              phone.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // BRAND
            Text(
              phone.brand,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // PRICE
            Text(
              'Rp ${phone.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 16),

            // SPEC
            Card(
              child: ListTile(
                leading: const Icon(Icons.memory),
                title: Text('RAM: ${phone.ram}'),
                subtitle: Text('Storage: ${phone.storage}'),
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Handphone'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur edit menyusul')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
