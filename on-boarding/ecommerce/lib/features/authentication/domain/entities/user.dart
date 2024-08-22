import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String access_token;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.access_token,
  }) : assert(name.length > 3);

  @override
  List<Object?> get props => [id, email, name, access_token];
}