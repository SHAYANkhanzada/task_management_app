class UserModel {
  final int id;
  final String name;
  final String email;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      // JSONPlaceholder doesn't have images, so we use a placeholder based on name
      profilePicture: 'https://ui-avatars.com/api/?name=${json['name']}&background=random&size=200',
    );
  }
}
