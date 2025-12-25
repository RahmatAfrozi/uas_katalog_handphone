import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/phone_model.dart';
import '../providers/phone_provider.dart';

class PhoneFormScreen extends StatefulWidget {
  final Phone? phone;

  const PhoneFormScreen({super.key, this.phone});

  @override
  State<PhoneFormScreen> createState() => _PhoneFormScreenState();
}

class _PhoneFormScreenState extends State<PhoneFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController brandController;
  late TextEditingController priceController;
  late TextEditingController ramController;
  late TextEditingController storageController;
  late TextEditingController imageController;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.phone?.name ?? '');
    brandController = TextEditingController(text: widget.phone?.brand ?? '');
    priceController = TextEditingController(
      text: widget.phone?.price.toString() ?? '',
    );
    ramController = TextEditingController(text: widget.phone?.ram ?? '');
    storageController = TextEditingController(
      text: widget.phone?.storage ?? '',
    );
    imageController = TextEditingController(text: widget.phone?.image ?? '');

    isFavorite = widget.phone?.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PhoneProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.phone == null ? 'Tambah Handphone' : 'Edit Handphone',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                ),
                TextFormField(
                  controller: brandController,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Brand wajib diisi' : null,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Harga wajib diisi' : null,
                ),
                TextFormField(
                  controller: ramController,
                  decoration: const InputDecoration(labelText: 'RAM'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'RAM wajib diisi' : null,
                ),
                TextFormField(
                  controller: storageController,
                  decoration: const InputDecoration(labelText: 'Storage'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Storage wajib diisi' : null,
                ),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Path Gambar'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Gambar wajib diisi' : null,
                ),

                const SizedBox(height: 12),

                SwitchListTile(
                  title: const Text('Jadikan Favorit'),
                  value: isFavorite,
                  onChanged: (value) {
                    setState(() {
                      isFavorite = value;
                    });
                  },
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final phone = Phone(
                      id:
                          widget.phone?.id ??
                          DateTime.now().millisecondsSinceEpoch,
                      name: nameController.text,
                      brand: brandController.text,
                      price: int.parse(priceController.text),
                      ram: ramController.text,
                      storage: storageController.text,
                      image: imageController.text,
                      isFavorite: isFavorite,
                    );

                    if (widget.phone == null) {
                      provider.addPhone(phone);
                    } else {
                      provider.updatePhone(phone);
                    }

                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
