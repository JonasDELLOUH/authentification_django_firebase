import 'package:authentification_django_firebase/core/services/firebase/firebase_auth_methods.dart';
import 'package:authentification_django_firebase/screens/authentification/forget_password.dart';
import 'package:authentification_django_firebase/screens/authentification/login.dart';
import 'package:authentification_django_firebase/screens/authentification/reset_password.dart';
import 'package:authentification_django_firebase/screens/authentification/sign_up.dart';
import 'package:authentification_django_firebase/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const Login(),
    //   debugShowCheckedModeBanner: false,
    // );
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
          context
              .read<FirebaseAuthMethods>()
              .authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
        routes: {
          SignUp.routeName: (context) =>
          const SignUp(),
          ForgetPassword.routeName: (context) => const ForgetPassword(),
          Login.routeName: (context) => const Login(),
          ResetPassword.routeName: (context) => const ResetPassword(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Home();
    }
    return const Login();
  }
}
