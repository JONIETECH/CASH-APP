import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''Welcome to Finance Tracker! These Terms and Conditions ("Terms") govern your use of our mobile application and any related services provided by Finance Tracker. By accessing or using the App, you agree to be bound by these Terms. If you do not agree with these Terms, please do not use the app.

1. Use of the App

1.1 Eligibility: You must be at least 18 years old to use the App. By using the App, you represent and warrant that you have the legal capacity to enter into a binding agreement.

1.2 Account Creation: To use certain features of the App, you must create an account. You agree to provide accurate, current, and complete information during the registration process and update such information to keep it accurate, current, and complete.

1.3 Account Security: You are responsible for maintaining the confidentiality of your login credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.

1.4 User Conduct: You agree not to use the App for any unlawful or prohibited purpose. You agree not to interfere with or disrupt the App or servers or networks connected to the App.

2. Financial Information

2.1 Data Collection: The App may collect and store personal financial information, such as income, expenses, and transaction history. By using the app, you consent to the collection, use, and sharing of this information as described in our Privacy Policy.

2.2 Accuracy of Information: While we strive to provide accurate and up-to-date financial information, we cannot guarantee the accuracy, completeness, or reliability of any information provided through the App. You acknowledge that any reliance on such information is at your own risk.

2.3 Personal Responsibility: You are responsible for managing your finances and making financial decisions. The App provides tools and information to assist you, but it is not a substitute for professional financial advice.


3. Intellectual Property

3.1 Ownership: The App and all content, features, and functionality (including but not limited to text, graphics, logos, icons, images, audio clips, and software) are the exclusive property of Finance Tracker and its licensors and are protected by copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.

3.2 License: Subject to these Terms, we grant you a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial use.

3.3 Restrictions: You agree not to reproduce, distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store, or transmit any of the material on our App, except as permitted under these Terms1''',
        ),
      ),
    );
  }
}