import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_weight_tracker/constants/routes.dart';
import 'package:firestore_weight_tracker/screens/home_page.dart';
import 'package:firestore_weight_tracker/screens/login.dart';
import 'package:firestore_weight_tracker/view_model/login_provider.dart';
import 'package:firestore_weight_tracker/view_model/weight_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool currentUser = FirebaseAuth.instance.currentUser == null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<WeightProvider>(
            create: (context) => WeightProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          loginRoute: (context) => const LoginPage(),
          homePageRoute: (context) => const HomePage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: currentUser ? const LoginPage() : const HomePage(),
      ),
    ),
  );
}
