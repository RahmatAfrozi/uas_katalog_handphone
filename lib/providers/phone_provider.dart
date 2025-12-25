import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import '../services/api_service.dart';

class PhoneProvider extends ChangeNotifier {
  final List<Phone> _phones = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ================= GETTER =================
  List<Phone> get phones => List.unmodifiable(_phones);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ================= FETCH (GET API) =================
  Future<void> fetchPhones() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await ApiService.fetchPhones();
      _phones
        ..clear()
        ..addAll(result);
    } catch (e) {
      // ⛔ fallback jika API gagal
      _phones
        ..clear()
        ..addAll([
          Phone(
            id: 1,
            name: 'iPhone 13',
            brand: 'Apple',
            price: 14000000,
            ram: '4 GB',
            storage: '128 GB',
            image: 'assets/images/iphone13.jpg',
          ),
          Phone(
            id: 2,
            name: 'iPhone 14',
            brand: 'Apple',
            price: 16000000,
            ram: '6 GB',
            storage: '256 GB',
            image: 'assets/images/iphone14.jpg',
          ),
          Phone(
            id: 3,
            name: 'iPhone 15',
            brand: 'Apple',
            price: 18000000,
            ram: '8 GB',
            storage: '256 GB',
            image: 'assets/images/iphone15.jpg',
          ),
          Phone(
            id: 4,
            name: 'iPhone 15 Plus',
            brand: 'Apple',
            price: 19000000,
            ram: '8 GB',
            storage: '256 GB',
            image: 'assets/images/iphone15_promax.jpg',
          ),
          Phone(
            id: 5,
            name: 'iPhone 16',
            brand: 'Apple',
            price: 25000000,
            ram: '12 GB',
            storage: '512 GB',
            image: 'assets/images/iphone16.jpg',
          ),
          Phone(
            id: 6,
            name: 'iPhone 15 Pro Max',
            brand: 'Apple',
            price: 22000000,
            ram: '8 GB',
            storage: '512 GB',
            image: 'assets/images/iphone15_promax.jpg',
          ),
        ]);

      _errorMessage = 'Gagal mengambil data dari server';
    }

    _isLoading = false;
    notifyListeners();
  }

  // ================= TAMBAH =================
  void addPhone(Phone phone) {
    _phones.add(phone);
    notifyListeners();
  }

  // ================= EDIT =================
  void updatePhone(Phone updatedPhone) {
    final index = _phones.indexWhere((p) => p.id == updatedPhone.id);
    if (index < 0) return;

    _phones[index] = updatedPhone;
    notifyListeners();
  }

  // ================= HAPUS =================
  void deletePhone(int id) {
    _phones.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  // ================= FAVORIT =================
  void toggleFavorite(int id) {
    final index = _phones.indexWhere((p) => p.id == id);
    if (index < 0) return;

    _phones[index].isFavorite = !_phones[index].isFavorite;
    notifyListeners();
  }

  // ================= LIST FAVORIT =================
  List<Phone> get favoritePhones =>
      _phones.where((p) => p.isFavorite).toList(growable: false);
}
