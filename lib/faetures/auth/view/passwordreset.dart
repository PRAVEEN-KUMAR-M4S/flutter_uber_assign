
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/faetures/auth/textfield.dart';

class Passwordreset extends StatefulWidget {
  const Passwordreset({super.key});

  @override
  State<Passwordreset> createState() => _PasswordresetState();
}

class _PasswordresetState extends State<Passwordreset> {
  final _resetcontroller = TextEditingController();

  @override
  void dispose() {
    _resetcontroller.dispose();
    super.dispose();
  }

  Future passrest() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _resetcontroller.text.trim(),
      );
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Your reset link is send to your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'To reset the password enter the email ',
             
            ),
          ),
          TextField1(
            controllers: _resetcontroller,
            hint: 'Email',
            obscuretext: false,
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: passrest,
            color: Colors.grey,
            child: const Text('reset'),
          )
        ],
      ),
    );
  }
}
