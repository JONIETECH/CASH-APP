import 'package:flutter/material.dart';

class ProfilePictureSection extends StatelessWidget {
  final String profilePictureUrl;

  const ProfilePictureSection({
    Key? key,
    required this.profilePictureUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(profilePictureUrl),
        onBackgroundImageError: (_, __) {
          // Handle image load error, e.g., by showing a placeholder image
          const AssetImage('assets/images/placeholder.png');
        },
      ),
    );
  }
}
