import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/core/common/widgets/loader.dart';
import 'package:finance_tracker/core/theme/app_pallete.dart';
import 'package:finance_tracker/core/utils/show_snackbar.dart';
import 'package:finance_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:finance_tracker/features/auth/presentation/pages/signup_page.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/auth_field.dart';
import 'package:finance_tracker/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_formKey.currentState!.validate();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
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
                    const SizedBox(
                        height: 100), // To ensure content is centered
                    const Text(
                      'Sign In:',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    AuthField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthGradientButton(
                      buttonText: 'Sign In',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim()),
                              );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          SignupPage.route(),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 100), // To ensure content is centered
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
