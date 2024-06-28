import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('''Last updated: [27/06/24]
1. Introduction
Welcome to Finance Tracker! We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about this privacy policy, or our practices with regards to your personal information, please contact us at financetracker@gmail.com.

2. Information We Collect
We collect personal information that you voluntarily provide to us when you register on the app, express an interest in obtaining information about us or our products and services, participate in activities on the App or otherwise when you contact us.

The personal information that we collect depends on the context of your interactions with us. The personal information we collect may include the following:
Personal Information Provided by You: We collect names, phone numbers, email addresses, and other similar information.
Financial Data: We collect data necessary to track your financial activities, such as income, expenses, and transactions. This may include bank account details, transaction history, and other financial data.

3. Information Collected Automatically
We automatically collect certain information when you visit, use, or navigate the App. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our App, and other technical information. This information is primarily needed to maintain the security and operation of our App and for our internal analytics and reporting purposes.

4. How We Use Your Information
We use personal information collected via our App for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations. We indicate the specific processing grounds we rely on next to each purpose listed below:

To facilitate account creation and logon process.
To send administrative information to you.
To fulfill and manage your orders.
To manage user accounts.
To send you marketing and promotional communications.
To deliver targeted advertising to you.
To enforce our terms, conditions, and policies.
To respond to legal requests and prevent harm.
To deliver services to the user.
To analyze and track financial trends and performance.
To provide financial insights and recommendations.

5. Sharing Your Information
We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.

6. How We Protect Your Information
We aim to protect your personal information through a system of organizational and technical security measures. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information.

7. Your Privacy Rights
You may review, change, or terminate your account at any time. If you believe we are unlawfully processing your personal information, you also have the right to complain to your local data protection supervisory authority.

8. Policy Changes
We may update this privacy policy from time to time in order to reflect changes to our practices or for other operational, legal, or regulatory reasons. When we make updates, we will revise the "Last updated" date at the top of this privacy policy. We encourage you to review this privacy policy frequently to be informed of how we are protecting your information.'''


        ),
      ),
    );
  }
}
