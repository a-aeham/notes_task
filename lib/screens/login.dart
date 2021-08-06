import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_task/screens/notes.dart';
import 'package:notes_task/screens/register.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 40,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(height: 24),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () => login(context),
              child: Text("Login"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have account ?'),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Text("Register")),
              ],
            )
          ],
        ),
      ),
    );
  }

  login(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, 
              password: passwordController.text);
      Navigator.of(context)
          .pushReplacement(
            MaterialPageRoute(
              builder: (_) => Notes()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found, Register!');
      } else if (e.code == 'wrong-password') {
        print('Invalid Password!');
      }
    }
  }
}
