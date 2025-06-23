// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: pwdController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorDialog(e.code);
    }
  }

  void errorDialog(String errCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errCode),
        backgroundColor: Theme.of(context).colorScheme.error, //
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                const Text(
                  'Hello, Welcome back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist',
                  ),
                ),

                const SizedBox(height: 64),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: const Color.fromARGB(235, 0, 0, 0)),
                  decoration: InputDecoration(
                    hintText: 'Username or Email',
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pwdController,
                  style: TextStyle(color: const Color.fromARGB(235, 0, 0, 0)),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),

                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.5),
                  ),
                  obscureText: true,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 214, 169, 7),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                SizedBox(
                  // width: 250,
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => signUserIn(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                // Spacer(),
                const SizedBox(height: 56),
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 0.5)),
                    SizedBox(width: 10),
                    const Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Divider(thickness: 0.5)),
                  ],
                ),
                const SizedBox(height: 26),

                //* google
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 22,
                          width: 22,
                        ),
                        const SizedBox(width: 8),
                        const Text('login with Google'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                //* facebook
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/facebook.png',
                          height: 22,
                          width: 22,
                        ),
                        const SizedBox(width: 8),
                        const Text('login with Github'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
