import 'package:flutter/material.dart';
import 'main_page.dart';
import 'signup_page.dart';
import 'package:cementery/dbHelper/mongodb.dart'; // Import the MongoDB helper

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FocusNode _usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/Sotacib.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                TextField(
                  focusNode: _usernameFocusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        const Text('Se souvenir de moi'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password logic here
                      },
                      child: const Text('Mot de passe oublié ?'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // This will ensure the connection is established or reused
                      await MongoDatabase.connect();

                      // Display a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Connected successfully!')),
                      );

                      // Navigate to the MainPage after successful connection
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    } catch (e) {
                      // Display an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to connect!: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // Stretched button
                    backgroundColor: Colors.blue, // Blue color
                  ),
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Vous n\'avez pas de compte ?'),
                    TextButton(
                      child: const Text('S\'inscrire'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/Molins_Logo.png',
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
