import 'package:finance_tracker/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      );
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextForm Controller
  TextEditingController emailController = TextEditingController();

  // Form Validation
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      // TODO: Perform sign-up logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          automaticallyImplyLeading: false,
          
        ),
        body: Column(
          children: [
            const Text(" Please Enter Your Email and you will be sent a message to reset your password"),
            TextFormField(
              controller: emailController,
              decoration:  InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white), 
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[300],
                filled: true,

                ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) => emailController.text = value!,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _validateAndSubmit,
              child: const Text('Reset Password'),
              
            ),
            const SizedBox(height: 16.0),
            Center(
              child: GestureDetector(
                onTap: _navigateToSignIn,
                child: RichText(
                  text: const TextSpan(
                    text: 'Have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Goto SignUp Page
  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }
}
