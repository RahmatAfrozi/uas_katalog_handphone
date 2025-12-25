class Phone {
  final int id;
  final String name;
  final String brand;
  final int price;
  final String ram;
  final String storage;
  final String image;
  bool isFavorite;

  Phone({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.ram,
    required this.storage,
    required this.image,
    this.isFavorite = false,
  });

  Phone copyWith({
    int? id,
    String? name,
    String? brand,
    int? price,
    String? ram,
    String? storage,
    String? image,
    bool? isFavorite,
  }) {
    return Phone(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      ram: ram ?? this.ram,
      storage: storage ?? this.storage,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
