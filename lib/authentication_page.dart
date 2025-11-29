import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4d2963);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        'The UNION',
                        style: TextStyle(
                          color: purple,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Sign in',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Choose how you would like too sing in",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Sign in with shop',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Row(children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child:
                            Text('or', style: TextStyle(color: Colors.black)),
                      ),
                      Expanded(child: Divider())
                    ]),

                    const SizedBox(height: 16),
                    //Email
                    TextField(
                      key: const Key('auth_email'),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                    ),

                    //continue button
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Continue',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Create an account',
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
