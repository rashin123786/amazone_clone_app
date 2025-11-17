import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/presentation/provider/cart_controller.dart';
import 'package:test/presentation/screens/home_screen.dart';
import 'package:test/presentation/provider/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Amazon-like logo
                CachedNetworkImage(
                  width: 200,
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
                  errorWidget: (context, url, error) => SizedBox(),
                ),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign in or create account",
                          style: GoogleFonts.roboto(),
                        ),
                        const SizedBox(height: 20),

                        // EMAIL
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: email,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter Email ';
                            } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(v)) {
                              return 'Enter valid mail';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // PASSWORD
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          validator: (v) =>
                              v!.isEmpty ? "Enter password" : null,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // SIGN IN BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD814),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: auth.isLoading
                                ? null
                                : () async {
                                    if (_form.currentState!.validate()) {
                                      String? loginError = await auth
                                          .signInEmailAuth(
                                            email.text.trim(),
                                            password.text.trim(),
                                          );

                                      if (loginError == null) {
                                        // Login success
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Login Successful"),
                                          ),
                                        );
                                        cartController.listenToCart(
                                          auth.currentUser?.uid ?? "",
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                        );
                                        return;
                                      }

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Creating account..."),
                                        ),
                                      );

                                      String? signupError = await auth
                                          .signUpEmailAuth(
                                            email.text.trim(),
                                            password.text.trim(),
                                          );

                                      if (signupError == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Account created!"),
                                          ),
                                        );
                                        cartController.listenToCart(
                                          auth.currentUser?.uid ?? "",
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(signupError)),
                                        );
                                      }
                                    }
                                  },
                            child: auth.isLoading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : const Text("Continue"),
                          ),
                        ),

                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(child: Divider(endIndent: 10, indent: 10)),
                            Text("Or"),
                            Expanded(child: Divider(endIndent: 10, indent: 10)),
                          ],
                        ),
                        Center(
                          child: TextButton.icon(
                            onPressed: () async {
                              await auth.signInWithGoogle();
                              if (auth.currentUser != null) {
                                cartController.listenToCart(
                                  auth.currentUser?.uid ?? "",
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            },
                            label: Text("SignIn With Google"),
                            icon: Image.network(
                              'https://cdn-teams-slug.flaticon.com/google.jpg',
                              height: 30,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
