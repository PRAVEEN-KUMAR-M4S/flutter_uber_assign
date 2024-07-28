
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uber_clone/core/theme/app_theme.dart';
import 'package:uber_clone/faetures/auth/auth_navigator.dart';
import 'package:uber_clone/faetures/auth/bloc/authentication_bloc.dart';
import 'package:uber_clone/faetures/auth/repository/authentication.dart';
import 'package:uber_clone/faetures/home/bloc/fetch_data_bloc.dart';
import 'package:uber_clone/faetures/home/repository/repository.dart';
import 'package:uber_clone/faetures/home/view/pages/home_screen.dart';


import 'package:uber_clone/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthService(),
        ),
         RepositoryProvider(
          create: (context) => FetchUserDataService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
         // BlocProvider(create: (context)=>AppuserCubit()),
            BlocProvider(
            create: (context) =>
                AuthenticationBloc(context.read<AuthService>()),
          ),
          BlocProvider(create: (context)=>FetchDataBloc(context.read<FetchUserDataService>()))
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
  
      home:const AuthNavigator(),
        
    );
  }
}
