import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardBloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/networkConnectivity.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Containers/MainHomeContainer/mainHomeContainer.dart';
import 'package:locteca/ui/Screen/Buy/agentDetailScreen.dart';
import 'package:locteca/ui/Screen/LoginScreen/loginScreen.dart';
import 'package:locteca/ui/Screen/NetworkFailureScreen/networkFailureScreen.dart';
import 'package:locteca/ui/Screen/SplashScreen/spalshScreen.dart';
import 'bloc/agentsBloc/agentsBloc.dart';
import 'bloc/userAuthBloc/userAuthBloc.dart';

// void main() {
//   UserAuthRepository userAuthRepository = UserAuthRepository();
//   runApp(MultiBlocProvider(providers: [

//       BlocProvider<SignUpBloc>(
//       create: (context) => SignUpBloc( ),
//     ),
//     BlocProvider<LoginBloc>(
//       create: (context) => LoginBloc( ),
//     ),
//     BlocProvider<UserAuthBloc>(
//       create: (context) {
//         return UserAuthBloc(userAuthRepository: userAuthRepository)
//           ..add(AuthStarted());
//       },
//     ),
//   ], child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       home: LoginPage(),
//     );
//   }
// }

void main() async {
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserAuthRepository();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MultiBlocProvider(
          providers: [
            BlocProvider<UserAuthBloc>(
              create: (context) {
                return UserAuthBloc(userAuthRepository: userRepository)
                  ..add(AuthStarted());
              },
            ),
            BlocProvider<LeaderBoardBloc>(
              create: (context) => LeaderBoardBloc(),
            ),
            BlocProvider<LeaguesBloc>(
              create: (context) => LeaguesBloc(),
            ),
            BlocProvider<AgentsBloc>(
              create: (context) => AgentsBloc(),
            ),
          ],
          child: App(
            userRepository: userRepository,
          ))));
}

class App extends StatefulWidget {
  final UserAuthRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool networkCheck = false;

  @override
  void initState() {
    NetworkConnectivity.check().then((internet) {
      if (internet) {
        setState(() {
          networkCheck = true;
        });
      } else {
        //show network erro

        setState(() {
          networkCheck = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: networkCheck
          ? BlocBuilder<UserAuthBloc, UserAuthState>(
              builder: (context, state) {
                if (state is AuthInitial) {
                  return SplashScreen();
                }

                if (state is AuthInProgress) {
                  return LoadingIndicator(AppTheme.appCardColor);
                }

                if (state is AuthSuccess) {
                  return MainHomeContainer();
                }
                if (state is AuthSuccessAsAgent) {
                  return AgentDetailScreen();
                }

                if (state is AuthFailure) {
                  return LoginPage(userAuthRepository: widget.userRepository);
                }

                return Container();
              },
            )
          : NetworkFauilureScreen(
              contextA: context,
            ),
    );
  }
}
