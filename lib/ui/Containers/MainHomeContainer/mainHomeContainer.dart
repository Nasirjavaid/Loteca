import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locteca/ui/Screen/Buy/buy.dart';

import 'package:locteca/ui/Screen/GeneralRanking/generalRanking.dart';
import 'package:locteca/ui/Screen/MakeBet/makeBet.dart';
import 'package:locteca/ui/Screen/MyLeague/myLeague.dart';
import 'package:locteca/ui/Screen/Result/result.dart';
import 'package:locteca/config/appTheme.dart';
import 'package:easy_localization/easy_localization.dart';

// class HomeCintainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         return CartBloc();
//       },
//       child: MainHomeContainer(),
//     );
//   }
// }

class MainHomeContainer extends StatefulWidget {
  @override
  _MainHomeContainerState createState() => _MainHomeContainerState();
}

class _MainHomeContainerState extends State<MainHomeContainer>
    with WidgetsBindingObserver {
  int _currentIndex = 0;

  final allScreenDestiNations = [
    MakeBetMain(),
    MyLeagueMain(),
    ResultMain(),
    GeneralRankingMain(),
    BuyMain()
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // Methods.storeStateToSharedPref(false);
    // WidgetsBinding.instance.addObserver(this);
    // callCartFromSharedPrefrences();

    super.initState();
  }

  // void callCartFromSharedPrefrences() async {
  //   BlocProvider.of<CartBloc>(context)
  //       .add(GetDataFromSharedPrefrencesCartEvent());
  // }

  // @override
  // void dispose() {
  //   // BlocProvider.of<CartBloc>(context)
  //   //     .add(SaveDataToSharedPrefrencesCartEvent());
  //   WidgetsBinding.instance.removeObserver(this);

  //   super.dispose();
  // }

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     BlocProvider.of<CartBloc>(context)
  //         .add(SaveDataToSharedPrefrencesCartEvent());
  //   }

  //   if (state == AppLifecycleState.resumed) {
  //     BlocProvider.of<CartBloc>(context)
  //         .add(GetDataFromSharedPrefrencesCartEvent());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // extendBodyBehindAppBar: true,

      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white38),

      //   elevation: 0.0,
      //   actions: [
      //     IconButton(
      //         icon: Icon(
      //           FontAwesomeIcons.questionCircle,
      //           color: Colors.white38,
      //           size: 18,
      //         ),
      //         onPressed: null),
      //   ],
      //   toolbarHeight: 20,
      //   centerTitle: true,
      //    backgroundColor: AppTheme.appDefaultColor,
      //  // backgroundColor: Colors.transparent,
      //   // title: Text(
      //   //   "Loteca",
      //   //   style:
      //   //       Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      //   // ),
      // ),
      body: SafeArea(
        top: false,
        child:
            IndexedStack(index: _currentIndex, children: allScreenDestiNations),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.appDefaultColor,
        unselectedItemColor: Colors.black54,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                FontAwesomeIcons.battleNet,
                size: 15,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                'Make Bet'.tr().toString(),
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Icon(
                FontAwesomeIcons.layerGroup,
                size: 15,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                'My Leagues'.tr().toString(),
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.list,
              size: 15,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                'Result'.tr().toString(),
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Icon(
                FontAwesomeIcons.chartLine,
                size: 15,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                'Ranking'.tr().toString(),
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Icon(
                Icons.monetization_on,
                size: 15,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                'Buy'.tr().toString(),
                style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ),
          )
        ],
      ),
      // drawer: MyNaveDrawerMain(),
    );
  }
}
