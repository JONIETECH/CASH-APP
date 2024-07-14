import 'package:finance_tracker/features/security/domain/entities/biometric_status.dart';


class BiometricStatusModel extends BiometricStatus {
  const BiometricStatusModel({required super.isEnabled});

  factory BiometricStatusModel.fromJson(Map<String, dynamic> json) {
    return BiometricStatusModel(
      isEnabled: json['isEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
    };
  }
}
