import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_task/screens/notes.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Register',style: TextStyle(
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
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () => register(context),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }

  register(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Notes()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
