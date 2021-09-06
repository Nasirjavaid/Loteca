import 'package:locteca/model/agentDashboardModel.dart';
import 'package:locteca/model/userDashboard.dart';
import 'package:locteca/service/userDashboardService.dart';

class UserDashboardRepository {
  Future<UserDashboard> getUserDashboardData() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    UserDashboard userDashboard = UserDashboard();
    UserDashboardService userDashboardService = UserDashboardService();

    userDashboard = await userDashboardService.getUserDashboardData();

    if (userDashboard != null) {
      return userDashboard;
    }
    return null;
  }
}