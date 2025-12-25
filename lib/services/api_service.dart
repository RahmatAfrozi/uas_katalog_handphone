import 'dart:async';
import '../models/phone_model.dart';

class ApiService {
  static Future<List<Phone>> fetchPhones() async {
    // ⏳ simulasi ambil data dari internet
    await Future.delayed(const Duration(seconds: 1));

    return [
      Phone(
        id: 1, // ✅ int
        name: 'iPhone 13',
        brand: 'Apple',
        price: 12000000,
        ram: '4 GB',
        storage: '128 GB',
        image: 'assets/images/iphone13.jpg',
      ),
      Phone(
        id: 2,
        name: 'iPhone 14',
        brand: 'Apple',
        price: 14000000,
        ram: '6 GB',
        storage: '128 GB',
        image: 'assets/images/iphone14.jpg',
      ),
      Phone(
        id: 3,
        name: 'iPhone 15',
        brand: 'Apple',
        price: 16000000,
        ram: '6 GB',
        storage: '256 GB',
        image: 'assets/images/iphone15.jpg',
      ),
      Phone(
        id: 4,
        name: 'iPhone 16',
        brand: 'Apple',
        price: 18000000,
        ram: '8 GB',
        storage: '256 GB',
        image: 'assets/images/iphone16.jpg',
      ),
      Phone(
        id: 5,
        name: 'iPhone 15 Pro Max',
        brand: 'Apple',
        price: 20000000,
        ram: '8 GB',
        storage: '512 GB',
        image: 'assets/images/iphone15_promax.jpg',
      ),
      Phone(
        id: 6,
        name: 'iPhone SE',
        brand: 'Apple',
        price: 8000000,
        ram: '4 GB',
        storage: '64 GB',
        image: 'assets/images/iphone13.jpg',
      ),
    ];
  }
}
