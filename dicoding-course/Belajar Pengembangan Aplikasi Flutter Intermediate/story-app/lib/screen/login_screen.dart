import 'package:storyapp/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) => value!.isEmpty ? "Please enter your email" : null,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) => value!.isEmpty ? "Please enter your password" : null,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(height: 8),
                Builder(
                  builder: ((context) {
                    final isLoading = context.watch<AuthProvider>().isLoading;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                final scaffoldMessenger = ScaffoldMessenger.of(context);
                                final User user = User(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                final authProvider = context.read<AuthProvider>();
                                final result = await authProvider.login(user);
                                if (!result.error) widget.onLogin();
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(result.message),
                                    backgroundColor: result.error ? Colors.red : Colors.green,
                                  ),
                                );
                              }
                            },
                      child: isLoading ? const CircularProgressIndicator() : const Text("LOGIN"),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => widget.onRegister(),
                  child: const Text("REGISTER"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
