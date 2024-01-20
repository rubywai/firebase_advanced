import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if(args != null){
      final snackBar = SnackBar(content: Text(args.toString()));
      Future((){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });

    }
    return const Scaffold(
      body: Center(
        child: Text('Login screen'),
      ),
    );
  }
}
