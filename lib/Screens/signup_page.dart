import 'package:cementery/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/User.dart';
import '../dbHelper/user_crud.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Créer un Compte',
                style: TextStyle(color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: [
             Image.asset(
                  'assets/images/Sotacib.png',
                  height: 200,
                ),
          Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
                const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Saisir votre E-mail',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Saisir Votre Nom',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Saisir Votre Mot de Passe',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Mot de Passe',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (passwordController.text == confirmPasswordController.text) {
                  final user = User(
                      username: userController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                    
                  await createUser(user);
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: "Créer Nouveau Utilisateur avec succées ${user.username}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                } else 
                  if (passwordController.text != confirmPasswordController.text)
                {
                  Fluttertoast.showToast(
                    msg: "Passwords do not match",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                else if (emailController.text.isEmpty ||
                    userController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Tous les champs sont obligatoire",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Stretched button
                backgroundColor: Colors.red.shade800, // Blue color
              ),
              child: const Text(
                'Créer un Compte',
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
              ),
            ),
          ],
        ),
          ],
        ) 
      ,
          
         
        
      )
    );
  }
}
