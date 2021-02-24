import 'package:locteca/model/agentDashboardModel.dart';
import 'package:locteca/service/agentDashboardService.dart';

class AgentDashBoardRepository {
  Future<AgentDashboardModel> getAgentDashboardData() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    AgentDashboardModel agentDashboardModel = AgentDashboardModel();
    AgentDashboardService agentDashboardService = AgentDashboardService();

    agentDashboardModel = await agentDashboardService.getAgentDashboardData();

    if (agentDashboardModel != null) {
      return agentDashboardModel;
    }
    return null;
  }
}