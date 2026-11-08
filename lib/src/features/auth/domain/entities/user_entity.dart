import 'package:jdonuts/src/core/core.dart';

class UserEntity extends Entity {
  final String name;
  final String identifier;
  final String? profilePictureUrl;
  final DateTime? dateOfBirth;

  const UserEntity({
    required super.id,
    required this.name,
    required this.identifier,
    this.profilePictureUrl,
    this.dateOfBirth,
  });
}
