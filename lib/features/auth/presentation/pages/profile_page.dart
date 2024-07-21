import 'package:finance_tracker/features/auth/presentation/widgets/logout_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/core/common/entities/user.dart';

class ProfilePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => ProfilePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Current Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            final User user = state.user;
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://mrwallpaper.com/images/hd/cool-profile-pictures-panda-man-gsl2ntkjj3hrk84s.jpg',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.2),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://mrwallpaper.com/images/hd/cool-profile-pictures-panda-man-gsl2ntkjj3hrk84s.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Name: ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: user.name,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Email: ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: user.email,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Add other user information here
                      ElevatedButton(
                        onPressed: () {
                          // Add logout or edit profile functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Add logout functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showLogoutConfirmationDialog(context);
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is AuthFailure) {
            return Center(
              child: Text('Failed to load profile: ${state.message}'),
            );
          } else {
            return const Center(child: Text('No profile data available'));
          }
        },
      ),
    );
  }
}
