import 'package:storyapp/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const RegisterScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Screen"),
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
                  controller: nameController,
                  validator: (value) => value!.isEmpty ? "Please enter your name!" : null,
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  validator: (value) => value!.isEmpty ? "Please enter your email!" : null,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) => value!.isEmpty ? "Please enter your password!" : null,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 8),
                Builder(builder: (context) {
                  final isLoading = context.watch<AuthProvider>().isLoading;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger = ScaffoldMessenger.of(context);
                              final User user = User(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              final authProvider = context.read<AuthProvider>();
                              final result = await authProvider.register(user);
                              if (!result.error) widget.onLogin();
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text(result.message),
                                  backgroundColor: result.error ? Colors.red : Colors.green,
                                ),
                              );
                            }
                          },
                    child: isLoading ? const CircularProgressIndicator() : const Text("REGISTER"),
                  );
                }),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => widget.onLogin(),
                  child: const Text("LOGIN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
