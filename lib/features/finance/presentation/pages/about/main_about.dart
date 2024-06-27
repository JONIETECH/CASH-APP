import 'package:flutter/material.dart';

import 'contact_support.dart';
import 'developer_information.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';


class MainAbout extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context)=> const MainAbout());
  const MainAbout({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Developer Information'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeveloperInformationPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Terms and Conditions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Contact Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactSupportPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

