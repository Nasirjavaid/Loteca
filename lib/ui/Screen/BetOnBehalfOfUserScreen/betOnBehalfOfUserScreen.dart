import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinBloc.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinEvent.dart';

import 'package:locteca/bloc/sendCoinBloc/sendCoinState.dart';
import 'package:locteca/config/appTheme.dart';

import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/BetOnBehalfOfUserScreen/noLiveRoundOrmissingUserWidget.dart';
import 'package:locteca/ui/Screen/BetOnBehalfOfUserScreen/userValidationWidgetForBet.dart';
import 'package:locteca/ui/Screen/BetOnBehalfOfUserScreen/userValidationWithEmailFormWidget.dart';


class BetOnBehalfOfUserScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return SendCoinBloc()..add(ShowUserValidationFormForBetEvent());
        },
        child: BetOnBehalfOfUserScreen(),
      ),
    );
  }
}

class BetOnBehalfOfUserScreen extends StatefulWidget {
  @override
  _BetOnBehalfOfUserScreenState createState() =>
      _BetOnBehalfOfUserScreenState();
}

class _BetOnBehalfOfUserScreenState extends State<BetOnBehalfOfUserScreen> {
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
          "Bet for Special User",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
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
    }, child:
            BlocBuilder<SendCoinBloc, SendCoinState>(builder: (context, state) {
      if (state is UserValidatedSuccessfullyState) {
        // mainRoundGlobal = MainRound();
        // mainRoundGlobal = state.mainRound;
        return UserValidationWidgetForBet(
          validateUser: state.validateUser,
        );
      }

      // if(state is SendCoinStateFailureState){
      //      return SendCoinFormWidgetMain();
      // }

      if (state is SendCoinStateInProgressState) {
        return LoadingIndicator(Colors.white);
      }

      if (state is ShowUserValidationWithEmailFormWidgetState) {
        return UserValidationWithEmailFormWidgetMain();
      }
      if (state is ShowBoxWhenUserCannotBeVerifiedOrOtherIssueState)
      {
        return noLiveRoundWidget(context,state.errorMessage);
      }

      return Container(color: Colors.white);
    }));
  }

   Widget noLiveRoundWidget(BuildContext context, String errorMessage) {
    return NoLiveRoundOrmissingUserWidget(
      content: Text(
        "$errorMessage",
        style: Theme.of(context).textTheme.headline6,
      ),
      title: Text(""),
      firstColor: Colors.amber,
      secondColor: Colors.white,
      headerIcon: Icon(
        Icons.error_outline,
        size: 120.0,
        color: Colors.white,
      ),
    );
  }
}
