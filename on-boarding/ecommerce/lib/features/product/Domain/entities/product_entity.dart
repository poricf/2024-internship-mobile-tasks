import 'package:equatable/equatable.dart';

import 'options_entity.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final double price;
  final double discount;
  final String description;
  final List<OptionEntity> options;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.discount,
    required this.description,
    required this.options,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        rating,
        price,
        discount,
        description,
        options,
      ];
}
