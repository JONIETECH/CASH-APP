import 'package:finance_tracker/features/finance/presentation/pages/dashboardpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/core/common/widgets/loader.dart';
import 'package:finance_tracker/core/utils/show_snackbar.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/auth_field.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finance Tracking app",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        // Remove the leading property to enable the default back arrow
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  showSnackBar(context, 'Successfully signed up!');
                  // Navigate to your home page or desired page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()), // Replace HomePage() with your actual homepage widget
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }

                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/logos/light.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'Sign up with us 🌏',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      AuthField(
                        hintText: "Name",
                        controller: nameController,
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        hintText: "Password",
                        controller: passwordController,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 20),
                      AuthGradientButton(
                        buttonText: 'Sign Up',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSignUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: nameController.text.trim(),
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Or sign up with',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(AuthSignUpWithGoogle());
                        },
                        child: Image.asset(
                          "assets/images/logos/google.png",
                          width: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, LoginPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "Login In",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Colors.blue[400],
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100), // To ensure content is centered
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
