class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String location;
  final String timeAgo;
  final String? badge;
  final String? tag;
  final String? distance;
  final bool isFeatured;
  final bool isNidVerified;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.location,
    required this.timeAgo,
    this.badge,
    this.tag,
    this.distance,
    this.isFeatured = false,
    this.isNidVerified = false,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? title,
    String? price,
    String? imageUrl,
    String? location,
    String? timeAgo,
    String? badge,
    String? tag,
    String? distance,
    bool? isFeatured,
    bool? isNidVerified,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      timeAgo: timeAgo ?? this.timeAgo,
      badge: badge ?? this.badge,
      tag: tag ?? this.tag,
      distance: distance ?? this.distance,
      isFeatured: isFeatured ?? this.isFeatured,
      isNidVerified: isNidVerified ?? this.isNidVerified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
