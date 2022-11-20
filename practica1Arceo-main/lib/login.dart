import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sof/home_page.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<void> googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );
          print(googleAuth.idToken);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        } on FirebaseException catch (error) {
          print(error.message);
        } catch (error) {
          print(error.toString());
        } finally {}
      }
    }
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await authInstance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          Text("Sign In", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Image.network("http://www.bardfieldacademy.org/wp-content/uploads/2016/07/music-notes-clip-art-png-music-1024x444.png", height: 400,),
          ElevatedButton.icon(onPressed: () async {
            print("Iniciar sesion ->");
            await googleSignIn(context);
          },
            icon: Image.asset('assets/images/googleIcon.png', height: 40,),
            label: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text('Iniciar Sesión con Google'),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.green,)
          ),
        ],
      )
    );
  }
}