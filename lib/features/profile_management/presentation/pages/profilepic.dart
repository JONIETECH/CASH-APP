import 'package:finance_tracker/features/profile_management/presentation/widgets/profile_picture_section.dart';
import 'package:finance_tracker/features/profile_management/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class ProfilepicSection extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ProfilepicSection());
  const ProfilepicSection({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfilepicSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _profilePictureUrl;
  late String _username;
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    // Initialize profile picture URL and other variables if needed
    _profilePictureUrl = 'https://example.com/profile_picture.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ProfilePictureSection(
                profilePictureUrl: _profilePictureUrl,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                label: 'Username',
                onSaved: (value) => _username = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                label: 'Password',
                obscureText: true,
                onSaved: (value) => _password = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Perform the profile update operation with the saved data
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
