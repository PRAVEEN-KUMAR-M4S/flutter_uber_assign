
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/faetures/auth/bloc/authentication_bloc.dart';
import 'package:uber_clone/faetures/auth/textfield.dart';
import 'package:uber_clone/faetures/home/view/pages/initial_screen.dart';

class RegPage extends StatefulWidget {
  final VoidCallback showloginpage;
  const RegPage({super.key, required this.showloginpage});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  bool isLoading = false;
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
    super.dispose();
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
              const SizedBox(height: 19),
              const Center(
                child: Icon(
                  Icons.lock,
                  size: 70,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Register below with your details',
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 5),
              TextField1(
                controllers: _name,
                hint: 'Name',
                obscuretext: false,
              ),
              const SizedBox(height: 1),
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
              const SizedBox(height: 1),
              TextField1(
                controllers: _confirmPassword,
                hint: 'Confirm password',
                obscuretext: true,
              ),
              const SizedBox(height: 1),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                if (state is RegistrationUserSuccess) {
                  Navigator.of(context).pushAndRemoveUntil(
                     MaterialPageRoute(builder: (context)=>const InitialScreen()), (route) => false);
                } else if (state is AuthenticationFailure) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Center(
                            child: Text(state.errorMsg),
                          ),
                        );
                      });
                }
              }, builder: (context, state) {
                if (state is AuthenticationLoadingState) {
                  isLoading = state.isLoading;
                }
                return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      RegisterUser(
                        context: context,
                        name: _name.text.trim(),
                        email: _username.text.trim(),
                        password: _password.text.trim(),
                        confirmPassword: _confirmPassword.text.trim(),
                      ),
                    );
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
                  child: state is AuthenticationLoadingState
                      ? const CircularProgressIndicator.adaptive()
                      : const Text('Sign Up'),
                );
              }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I am a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showloginpage,
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
