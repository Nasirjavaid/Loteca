import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryBloc.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryEvent.dart';
import 'package:locteca/bloc/passwordRecoveryBloc/passwordRecoveryState.dart';
import 'package:locteca/bloc/sendCoinBloc/sendCoinBloc.dart';

import 'package:locteca/bloc/sendCoinBloc/sendCoinState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/networkConnectivity.dart';

import 'package:locteca/main.dart';
import 'package:locteca/repository/userAuthRepository.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/ForgetPasswordScreen/codeMatchingForm.dart';
import 'package:locteca/ui/Screen/ForgetPasswordScreen/passwordRecovryForm.dart';
import 'package:locteca/ui/Screen/ForgetPasswordScreen/passwordUpdateForm.dart';
import 'package:locteca/ui/Screen/MakeBet/NoRoundLiveWidget.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/coinsRecipt.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/sendCoinFormWidget.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/userValidationWidget.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetPasswordScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return PasswordRecoveryBloc()
            ..add(ShowPasswordRecoveryEmailFormEvent());
        },
        child: ForgetPasswordScreen(),
      ),
    );
  }
}

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
          "Reset Password".tr().toString(),
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

    return BlocListener<PasswordRecoveryBloc, PasswordRecoveryState>(
        listener: (context, state) {
      if (state is PasswordRecoveryFailedState) {
        showMessageError("${state.passwordRecovery.message}");

        // print("Error : ${state.errorMessage}");
      }

      if (state is PasswordResetCodeSentSuccessfullyState) {
        if (state.passwordRecovery.message != null) {
          showMessageError("${state.passwordRecovery.message}");
        }

        // print("Error : ${state.errorMessage}");
      }

      // if (state is CoinSentSuccessfullyState) {
      //   Methods.showDialogueForCoinSentDetail(
      //     context,
      //     state.sendCoin,
      //   );
      // }
    }, child: BlocBuilder<PasswordRecoveryBloc, PasswordRecoveryState>(
            builder: (context, state) {
      if (state is PasswordRecoveryFailedState) {
        return PasswordRecoveryForm();
      }

      if (state is PasswordRecoveryInProgressState) {
        return LoadingIndicator(Colors.white);
      }
      if (state is ShowPasswordRecoveryFormState) {
        return PasswordRecoveryForm();
      }
      if (state is PasswordResetCodeSentSuccessfullyState) {
        return CodeMathchingForm(
          passwordRecovery: state.passwordRecovery,
        );
      }
      if (state is ShowPasswordUpdateFormState) {
        return PasswordUpdateForm(email: state.email);
      }

      if (state is PasswordUpdatedSuccessfullyState) {
        return confirmationWidget(context, state.passwordRecovery.message);
      }

      if (state is PasswordRecoveryCloseScreenState) {
        Navigator.pop(context);
      }

      return Container(color: Colors.white);
    }));
  }

  Widget confirmationWidget(BuildContext context, String errorMessage) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: NoRoundLiveWidget(
        content: Text(
          "$errorMessage",
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(""),
        firstColor: Colors.green,
        secondColor: Colors.white,
        headerIcon: Icon(
          Icons.done_all,
          size: 120.0,
          color: Colors.white,
        ),
      ),
    );
  }

  
}
