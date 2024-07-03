import 'package:finance_tracker/core/error/exceptions.dart';
import 'package:finance_tracker/features/profile_management/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getUserProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;
  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<ProfileModel>> getUserProfile() async {
    try {
      final user =
       await supabaseClient.from('profiles').select('*');
      return user 
      .map((users) => ProfileModel.fromJson(users)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
