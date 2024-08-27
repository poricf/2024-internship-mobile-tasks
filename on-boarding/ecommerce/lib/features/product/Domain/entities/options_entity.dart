import 'package:equatable/equatable.dart';

class OptionEntity extends Equatable{
  final String id;
  final String name;
  final double price;

  OptionEntity({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, price];
}
