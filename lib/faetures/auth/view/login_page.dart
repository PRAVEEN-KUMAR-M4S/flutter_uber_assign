import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/faetures/auth/bloc/authentication_bloc.dart';
import 'package:uber_clone/faetures/auth/textfield.dart';
import 'package:uber_clone/faetures/auth/view/passwordreset.dart';
import 'package:uber_clone/faetures/home/view/pages/initial_screen.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showregpage;
  const LoginPage({super.key, required this.showregpage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 55,
              ),
              const Center(
                child: Icon(
                  Icons.lock,
                  size: 70,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'welcome back you have been missed',
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField1(
                controllers: _username,
                hint: 'Email',
                obscuretext: false,
              ),
              TextField1(
                controllers: _password,
                hint: 'Password',
                obscuretext: true,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Passwordreset();
                        }));
                      },
                      child: const Text(
                        'Forgot _password?',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationSuccess) {
                    Navigator.of(context).pushAndRemoveUntil(
                       MaterialPageRoute(builder: (context)=>InitialScreen()) , (route) => false);
                  } else if (state is AuthenticationFailure) {
                    print(state.errorMsg);
                  }
                },
                builder: (context, state) {
                  if (state is AuthenticationLoadingState) {
                    isLoading = state.isLoading;
                  }
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          SignUpuser(
                              email: _username.text.trim(),
                              password: _password.text.trim()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 60),
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2,
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Login'),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member ? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showregpage,
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
