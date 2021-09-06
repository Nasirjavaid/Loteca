import 'package:locteca/model/agentsToBuyCoins.dart';
import 'package:locteca/service/agentsService.dart';


class AgentsRepository {
  Future<AgentsToBuyCoins> getAgents() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    AgentsToBuyCoins agentsToBuyCoins = AgentsToBuyCoins();
    AgentsService agentsService = AgentsService();

    agentsToBuyCoins = await agentsService.getAgents();

    if (agentsToBuyCoins != null) {
      return agentsToBuyCoins;
    }
    return null;
  }
}