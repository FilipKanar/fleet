import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fleet/view/screens/company/company_screen.dart';
import 'package:fleet/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    var authenticationProviders = [EmailAuthProvider()];
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in' : (context) => SignInScreen(
          providers: authenticationProviders,
          actions: [
            AuthStateChangeAction<SignedIn>((context, _) {
              Navigator.of(context).pushReplacementNamed('/home');
            }),
          ],
        ),
        '/profile' : (context) => ProfileScreen(
          providers: authenticationProviders,
        ),
        '/company': (context) => const CompanyScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
