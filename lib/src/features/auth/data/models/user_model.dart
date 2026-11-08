import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jdonuts/src/features/auth/domain/domain.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
sealed class UserModel extends UserEntity with _$UserModel {
  const UserModel._() : super(id: "", name: "", identifier: "");

  static const empty = UserModel(id: "", name: "", identifier: "");

  const factory UserModel({
    required String id,
    required String name,
    required String identifier,
    String? profilePictureUrl,
    DateTime? dateOfBirth,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static UserModel fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      name: user.name,
      identifier: user.identifier,
      profilePictureUrl: user.profilePictureUrl,
      dateOfBirth: user.dateOfBirth,
    );
  }
}
