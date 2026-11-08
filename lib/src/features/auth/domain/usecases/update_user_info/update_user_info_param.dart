class UpdateUserInfoParam {
  final String id;
  final String? name;
  final String? password;
  final String? profilePicturePath;
  final DateTime? dateOfBirth;

  const UpdateUserInfoParam({
    required this.id,
    this.name,
    this.password,
    this.profilePicturePath,
    this.dateOfBirth,
  });
}
