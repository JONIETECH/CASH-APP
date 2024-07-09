import 'package:finance_tracker/core/error/exceptions.dart';
import 'package:finance_tracker/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient client;

  ProfileRemoteDataSourceImpl({required this.client});
  
  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await client.auth.getUser();
      if (response == null || response.user == null) {
        throw ServerException('Failed to fetch user profile.');
      }
      final user = response.user!;
      final metadata = user.userMetadata ?? {};

      return UserModel(
        id: user.id,
        email: user.email ?? '',
        name: metadata['name'] ?? 'Unknown',
        // Add other fields as needed
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
