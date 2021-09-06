import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordBloc.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordEvent.dart';
import 'package:locteca/bloc/coinRecordBloc/coinRecordState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/model/coinRecord.dart';

import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/ui/Screen/MakeBet/userBetRecipt.dart';
import 'package:locteca/ui/Screen/SendCoinScreen/coinsRecipt.dart';

class ReciptScreenMain extends StatelessWidget {
  final int id;

  final int apiDirectionalCall;

  ReciptScreenMain({this.id, this.apiDirectionalCall});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return CoinRecordBloc()
            ..add(GetRecordReciptDetailsEvent(
                id: id, apiDirectionalCall: apiDirectionalCall));
        },
        child: Recipt(apiDirectionalCall: apiDirectionalCall,),
      ),
    );
  }
}

class Recipt extends StatefulWidget {
final int id;

  final int apiDirectionalCall;
  Recipt({this.id, this.apiDirectionalCall});
  @override
  _ReciptState createState() => _ReciptState();
}

class _ReciptState extends State<Recipt> {
  CoinRecord coinRecordGlobal = CoinRecord();
  Widget actionWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<CoinRecordBloc>(context)
                  .add(GetRecordReciptDetailsEvent(
                id: widget.id, apiDirectionalCall: widget.apiDirectionalCall));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),

        elevation: 0.0,
        actions: [actionWidget(context)],
        title: Text(
          "Recipt".tr().toString(),
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),

        centerTitle: true,
        // backgroundColor: AppTheme.appDefaultColor,

        backgroundColor: AppTheme.appDefaultColor,
      ),
      // body: _buildBody(context),

      body: BlocListener<CoinRecordBloc, CoinRecordState>(
          listener: (BuildContext context, state) {
        print("Printing state from bloc lstener, and state is :  $state");
      }, child: BlocBuilder<CoinRecordBloc, CoinRecordState>(
        builder: (BuildContext context, state) {
          if (state is UserCoinRecordReciptInProgressState) {
            return LoadingIndicator(Colors.indigo);
          }

          if (state is UserCoinRecordReciptSuccessState) {
            return CoinRecipt(sendCoin: state.sendCoin,apiDirectionalCall: widget.apiDirectionalCall,);
          }

          if (state is UserBetRecordReciptSuccessState) {
            return SingleChildScrollView(child: UserBetRecipt(mainRound: state.mainRound,apiDirectionalCall: widget.apiDirectionalCall,));
          }

          return Container();
        },
      )),
    );
  }

  Widget failedWidget(BuildContext context) {
    return FlatButton(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Icon(Icons.refresh, size: 60, color: AppTheme.nearlyBlue),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Tap to reload".tr().toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white54),
            ),
          ],
        ),
      ),
      onPressed: () {
        BlocProvider.of<CoinRecordBloc>(context).add(GetCoinRecordEvent());
      },
    );
  }
}
