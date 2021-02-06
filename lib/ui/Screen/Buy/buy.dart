import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/agentsBloc/agentsBloc.dart';
import 'package:locteca/bloc/agentsBloc/agentsEvent.dart';
import 'package:locteca/bloc/agentsBloc/agentsState.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:locteca/config/methods.dart';
import 'package:locteca/model/agentsToBuyCoins.dart';
import 'package:locteca/ui/CommonWidget/loadingIndicator.dart';
import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locteca/ui/Screen/DashboardScreen/myNavDrawer.dart';

class BuyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return AgentsBloc()..add(GetAgentsListEvent());
        },
        child: Buy(),
      ),
    );
  }
}

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white38),

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
        title: Text(
          "Buy",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),

        centerTitle: true,
        // backgroundColor: AppTheme.appDefaultColor,

        backgroundColor: AppTheme.appDefaultColor,
      ),
      // body: _buildBody(context),

      body: BlocListener<AgentsBloc, AgentsState>(
          listener: (BuildContext context, state) {
        print("Printing state from bloc lstener, and state is :  $state");
      }, child: BlocBuilder<AgentsBloc, AgentsState>(
        builder: (BuildContext context, state) {
          if (state is AgentsFailureState) {
            return Center(child: failedWidget(context));
          }
          if (state is AgentsSuccessState) {
            return _buildBody(context, state.agentsToBuyCoins);
          }
          if (state is AgentsInProgressState) {
            return LoadingIndicator(Colors.indigo);
          }
          return Container();
        },
      )),
      drawer: MyNaveDrawerMain(),
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
              "Tap to reload",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white54),
            ),
          ],
        ),
      ),
      onPressed: () {
        BlocProvider.of<AgentsBloc>(context).add(GetAgentsListEvent());
      },
    );
  }

  Widget _buildBody(BuildContext context, AgentsToBuyCoins agentsToBuyCoins) {
    return Container(
      //  color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: listofTeams(context, agentsToBuyCoins),
    );
  }

  Widget listofTeams(BuildContext context, AgentsToBuyCoins agentsToBuyCoins) {
    return Container(
      decoration: BoxDecoration(
          // color: AppTheme.appCardColor,
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: agentsToBuyCoins.agents.length == 0
                ? 1
                : agentsToBuyCoins.agents.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return agentsToBuyCoins.agents.length == 0
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text("No Items"),
                    ))
                  : listWiewItemCard(context, agentsToBuyCoins.agents[index]);
              // return listWiewItemCard(context);
            }),
      ),
    );
  }

  Widget listWiewItemCard(BuildContext context, Agents agents) {
    return InkWell(
      highlightColor: Colors.amber,
      onTap: () {
        Methods.showDialogWithAgentDetail(context,agents);
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.6),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Avatar(
                            circleShow: false,
                            circleColor: Colors.amber,
                            circleHeight: 22,
                            circleWidth: 22,
                            height: 60,
                            width: 60,
                            imageUrl: agents.image == null || agents.image == ""
                                ? "https://cdn.pixabay.com/photo/2018/08/26/23/55/woman-3633737__340.jpg"
                                : agents.image,
                            radius: 40,
                            backgroundColor: Colors.white,
                            borderColor: Colors.grey.shade300,
                            borderWidth: 4.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           agents.name == null || agents.name ==""? "Agent Name" : agents.name ,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Per coin rate :  N/A",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                          Text(
                            "Total avilable Coins: ${ agents.coins == null ||  agents.coins == "" ? "" :  agents.coins}",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                          Text(
                            "Phone : ${ agents.contacts[0].phone == null ||  agents.contacts[0].phone == "" ? "" :  agents.contacts[0].phone}",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  creditWidget(context),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Team Name",
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .bodyText2
                  //           .copyWith(color: Colors.white60),
                  //     ),
                  //     SizedBox(
                  //       width: 4,
                  //     ),
                  //     Icon(
                  //       Icons.flag,
                  //       size: 25,
                  //       color: Colors.white,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget creditWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(FontAwesomeIcons.coins, size: 20, color: AppTheme.nearlyGold),
            // SizedBox(
            //   width: 14,
            // ),
            Text("N/A",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
