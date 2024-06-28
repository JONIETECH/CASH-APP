// lib/features/settings/presentation/widgets/profile_picture_section.dart

import 'package:flutter/material.dart';

class ProfilePictureSection extends StatelessWidget {
  final String profilePictureUrl;

  ProfilePictureSection({required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: profilePictureUrl.isEmpty
              ? AssetImage('assets/default_profile_picture.png')
              : NetworkImage(profilePictureUrl) as ImageProvider,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Picture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                // Implement the logic to upload and get the profile picture URL
              },
              child: const Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
