import 'package:finance_tracker/features/auth/domain/entities/user.dart';

class ProfileModel extends User {
  ProfileModel({
    required super.id,
    required super.email,
    required super.name,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,

    );
  }
}
