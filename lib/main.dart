import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

void main() {
  FirebaseUIAuth.configureProviders(
      [
        EmailAuthProvider(),
      ]
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var providers = [EmailAuthProvider()];

    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in' : (context) => SignInScreen(
          providers: providers,
          actions: [
            AuthStateChangeAction<SignedIn>((context, _) {
              Navigator.of(context).pushReplacementNamed('/home');
            }),
          ],
        ),
        '/profile' : (context) => ProfileScreen(
          providers: providers,
        ),
      },
    );
  }
}
