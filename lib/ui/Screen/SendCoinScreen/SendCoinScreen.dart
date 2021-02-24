import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinBloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinEvent.dart';

import 'package:locteca/bloc/sendCoinBloc/sendCoinState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/main.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/sendCoinFormWidget.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/userValidationWidget.dart';



class SendCoinScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return SendCoinBloc()..add(ShowUserValidationFormSendCoinEvent());
        },
        child: SendCoinScreen(),
      ),
    );
  }
}
class SendCoinScreen extends StatefulWidget {
  @override
  _SendCoinScreenState createState() => _SendCoinScreenState();
}

class _SendCoinScreenState extends State<SendCoinScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
              "Send Coins",
              style: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),

            centerTitle: true,
            elevation: 0.0,
            actions: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: Colors.white38,
                    size: 18,
                  ),
                  onPressed: null),
            ],
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

    return BlocListener<SendCoinBloc, SendCoinState>(
        listener: (context, state) {
      if (state is SendCoinStateFailureState) {
        showMessageError("${state.errorMessage}");

        print("Error : ${state.errorMessage}");
      }
    }, child: BlocBuilder<SendCoinBloc, SendCoinState>(
            builder: (context, state) {
      if (state is UserValidatedSuccessfullyState) {
        // mainRoundGlobal = MainRound();
        // mainRoundGlobal = state.mainRound;
        return UserValidationWidget(validateUser: state.validateUser,);
      }

      if(state is SendCoinStateFailureState){
           return SendCoinFormWidgetMain();
      }

      if (state is SendCoinStateInProgressState) {
        return LoadingIndicator(Colors.white);
      }
      if (state is CoinSentSuccessfullyState) {
        return Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
              "Coins SuccessFully Sent",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: AppTheme.appCardColor),
            )));
      }

      if (state is ShowSendCoinFormWidgetState) {
        return SendCoinFormWidgetMain();
      }

      if(state is SendCoinCloseAndRefreshMainAdminDashboard)
      {

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
