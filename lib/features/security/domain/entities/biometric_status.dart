import 'package:equatable/equatable.dart';

class BiometricStatus extends Equatable {
  final bool isEnabled;

  const BiometricStatus({required this.isEnabled});

  @override
  List<Object?> get props => [isEnabled];
}
