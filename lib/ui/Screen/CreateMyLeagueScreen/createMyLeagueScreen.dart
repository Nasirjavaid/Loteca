import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueBloc.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueEvent.dart';
import 'package:locteca/bloc/createMyLeagueBloc/createMyLeagueState.dart';

import 'package:locteca/config/appTheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/main.dart';
import 'package:locteca/model/mainRound.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';

import 'package:locteca/ui/Screen/CreateMyLeagueScreen/createMyLeagueForm.dart';


class CreateMyLeagueScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return CreateMyLeagueBloc()..add(CreateMyLeagueShowInputFormEvent());
        },
        child: CreateMyLeagueScreen(),
      ),
    );
  }
}

class CreateMyLeagueScreen extends StatefulWidget {
  @override
  _CreateMyLeagueScreenState createState() => _CreateMyLeagueScreenState();
}

class _CreateMyLeagueScreenState extends State<CreateMyLeagueScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool widegtSwitch0 = false;
  bool widegtSwitch1 = false;
  bool widegtSwitch2 = false;
  int selectedPackageId = 0;
  String selectedPackageAccumulativePrice;
  MainRound mainRoundGlobal;
  final userRepository = UserAuthRepository();

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white38),
            title: Text(
              "Create My League",
              style: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),

            centerTitle: true,
            elevation: 0.0,
            // actions: [
            //   IconButton(
            //       icon: Icon(
            //         FontAwesomeIcons.questionCircle,
            //         color: Colors.white38,
            //         size: 18,
            //       ),
            //       onPressed: null),
            // ],
            // toolbarHeight: 50,

            backgroundColor: AppTheme.appDefaultColor,
            //backgroundColor: Colors.transparent,
            // title: Text(
            //   "Loteca",
            //   style:
            //       Theme.of(context).textTheme.button.copyWith(color: Colors.white),
            // ),
          ),
          backgroundColor: AppTheme.background,
          body: _buildBody(context),
        
      
    );
  }

  Widget _buildBody(BuildContext context) {
// return BlocConsumer<MainRoundBloc, MainRoundState>(
//       buildWhen: (previousState, state) {
//         return state is! DontBuild;
//       },
//       builder: (BuildContext context, state) {
//         return Text(state.text);
//       },
//       listener: (BuildContext context, state) {
//         if (state is ShowFlushbar) {

//         }
//       },
//     );

    return BlocListener<CreateMyLeagueBloc, CreateMyLeagueState>(
        listener: (context, state) {
      if (state is CreateMyLeagueFailureState) {
        showMessageError("${state.errorMessage}");

        print("Error : ${state.errorMessage}");
      }
    }, child: BlocBuilder<CreateMyLeagueBloc, CreateMyLeagueState>(
            builder: (context, state) {
      if (state is CreateMyLeagueSuccessState) {
        // mainRoundGlobal = MainRound();
        // mainRoundGlobal = state.mainRound;
        return Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
              "League Created Successfully",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: AppTheme.appCardColor),
            )));
      }

      if (state is CreateMyLeagueProgressState) {
        return LoadingIndicator(Colors.white);
      }
      if (state is CreateMyLeagueFailureState) {
        return CreateMyLeagueForm();
      }

      if (state is CreateMyLeagueShowInputFormState) {
        return CreateMyLeagueForm();
      }
      if (state is CreateMyLeagueAutoCloseAndReCallMyLeaguesApiState) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // add your code here.

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => App(
                      userRepository: userRepository,
                    )),
          );
        });
      }

      return Container(color: Colors.white);
    }));
  }
}
