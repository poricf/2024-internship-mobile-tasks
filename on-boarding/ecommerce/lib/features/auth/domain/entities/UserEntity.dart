import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String accessToken;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
  }) : assert(name.length >= 3);

  @override
  List<Object?> get props => [id, name, email, accessToken];
}
