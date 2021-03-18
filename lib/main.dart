import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:locteca/bloc/feedbackBloc/feedbackBloc.dart';
import 'package:locteca/bloc/leaderBoardBloc/leaderBoardBloc.dart';
import 'package:locteca/bloc/leaguesBloc/leaguesBloc.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthEvent.dart';
import 'package:locteca/bloc/userAuthBloc/userAuthState.dart';
import 'package:locteca/bloc/userProfileBloc/userProfileBloc.dart';
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
import 'bloc/leaderBoardBloc/leaderBoardBloc.dart';
import 'bloc/leaguesBloc/leaguesBloc.dart';
import 'bloc/userAuthBloc/userAuthBloc.dart';
import 'bloc/userAuthBloc/userAuthEvent.dart';
import 'bloc/userAuthBloc/userAuthState.dart';
import 'bloc/userProfileBloc/userProfileBloc.dart';
import 'config/appTheme.dart';
import 'repository/userAuthRepository.dart';
import 'ui/CommonWidget/loadingIndicator.dart';
import 'ui/Containers/MainHomeContainer/mainHomeContainer.dart';
import 'ui/Screen/LoginScreen/loginScreen.dart';
import 'ui/Screen/SplashScreen/spalshScreen.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print("Background FCM working ......................");
  dynamic data;
  if (message.containsKey('data')) {
    // Handle data message
    data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    data = message['notification'];
  }

  // Or do other work.
  return data;
}

void main() async {
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
            BlocProvider<UserProfileBloc>(
              create: (context) => UserProfileBloc(),
            ),
            BlocProvider<FeedbackBloc>(
              create: (context) => FeedbackBloc(),
            ),
          ],
          child: EasyLocalization(
            path: "assets/lang",
            saveLocale: true,
            supportedLocales: [
              //Locale('en', "US"),
              Locale('pt', "BR"),
            ],
            fallbackLocale: Locale('pt', "BR"),
            child: App(
              userRepository: userRepository,
            ),
          ))));
}

class App extends StatefulWidget {
  final UserAuthRepository userRepository;

  App({Key key, this.userRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final UserAuthRepository userAuthRepository = UserAuthRepository();

  // void _requestPermissions() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  // }

  // showNotification(dynamic messgae) async {
  //   var android = AndroidNotificationDetails('id', 'channel ', 'description',
  //       priority: Priority.high, importance: Importance.max);
  //   var iOS = IOSNotificationDetails();
  //   var platform = new NotificationDetails(android: android, iOS: iOS);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
  //       payload: 'Welcome to the Local Notification demo');
  // }

  // Future<dynamic> onSelectNotification(String payload) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return MainHomeContainer();
  //   }));
  // }

  bool networkCheck = false;

  @override
  void initState() {
    initializeDateFormatting();
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

    //  _requestPermissions();

    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings("@mipmap/launcher_icon");
    // var initializationSettingsIOs = IOSInitializationSettings();
    // var initSetttings = InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   iOS: initializationSettingsIOs,
    // );

    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     print("Message receved from firebse *********  : $message");
    //     showNotification(message);
    //   },
    //   //TODO: Change the implimentation for iOS,
    //   onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     showNotification(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     showNotification(message);
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // // _firebaseMessaging.getToken().then((String token) {
    // //   assert(token != null);
    // //   print("Push Messaging token: $token");
    // // });
    // // _firebaseMessaging.subscribeToTopic("matchscore");
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
                  return AgentDetailScreenMain();
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
