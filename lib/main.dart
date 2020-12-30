import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/signUpBloc/signUpBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userLoginBloc/loginBloc.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/Containers/MainHomeContainer/mainHomeContainer.dart';
import 'bloc/userAuthBloc/userAuthBloc.dart';

void main() {
  UserAuthRepository userAuthRepository = UserAuthRepository();
  runApp(MultiBlocProvider(providers: [

      BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc( ),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc( ),
    ),
    BlocProvider<UserAuthBloc>(
      create: (context) {
        return UserAuthBloc(userAuthRepository: userAuthRepository)
          ..add(AuthStarted());
      },
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MainHomeContainer(),
    );
  }
}
