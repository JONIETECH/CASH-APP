import 'package:finance_tracker/features/profile_management/presentation/widgets/custom_text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_picture_section.dart';

class ProfilePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const ProfilePage());
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final users = state.user; // Assuming state.users is a list of User
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  // Simulate fetching the profile picture URL for each user
                  final String profilePictureUrl = 'https://example.com/path/to/profile_picture_$index.jpg';
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      ProfilePictureSection(profilePictureUrl: profilePictureUrl),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Username',
                        initialValue: user.name,
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Email',
                        initialValue: user.email,
                        readOnly: true,
                      ),
                    ],
                  );
                },
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
