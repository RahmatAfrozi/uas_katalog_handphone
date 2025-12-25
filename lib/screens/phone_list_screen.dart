import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/phone_provider.dart';
import '../models/phone_model.dart';
import 'phone_form_screen.dart';
import 'phone_detail_screen.dart';

class PhoneListScreen extends StatefulWidget {
  const PhoneListScreen({super.key});

  @override
  State<PhoneListScreen> createState() => _PhoneListScreenState();
}

class _PhoneListScreenState extends State<PhoneListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PhoneProvider>().fetchPhones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhoneProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Handphone')),

      // ================= TOMBOL TAMBAH =================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PhoneFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: _buildBody(provider),
    );
  }

  Widget _buildBody(PhoneProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    if (provider.phones.isEmpty) {
      return const Center(child: Text('Data handphone kosong'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: provider.phones.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final Phone phone = provider.phones[index];

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhoneDetailScreen(phone: phone),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= GAMBAR =================
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          phone.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                      ),

                      // ================= FAVORIT =================
                      Positioned(
                        top: 6,
                        right: 6,
                        child: IconButton(
                          icon: Icon(
                            phone.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: phone.isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            provider.toggleFavorite(phone.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phone.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        phone.brand,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${phone.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ================= EDIT & HAPUS =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhoneFormScreen(phone: phone),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(context, phone),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= KONFIRMASI HAPUS =================
  void _confirmDelete(BuildContext context, Phone phone) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Data'),
        content: Text('Yakin ingin menghapus ${phone.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              context.read<PhoneProvider>().deletePhone(phone.id);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
