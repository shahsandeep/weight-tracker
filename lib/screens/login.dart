import 'package:firestore_weight_tracker/constants/routes.dart';
import 'package:firestore_weight_tracker/enums/enum.dart';
import 'package:firestore_weight_tracker/view_model/login_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Center(child: _getWidget(context, provider.loadingStatus)),
    );
  }

  _getWidget(BuildContext context, LoadingStatus status) {
    if (status == LoadingStatus.loading) {
      return const CircularProgressIndicator();
    }
    return ElevatedButton(
      onPressed: () async {
        bool response = await provider.login();
        if (response) {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, homePageRoute, (route) => false);
          }
        }
      },
      child: const Text('Login'),
    );
  }
}
