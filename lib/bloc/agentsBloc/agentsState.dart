import 'package:locteca/model/agentsToBuyCoins.dart';
import 'package:locteca/model/leaguesModel.dart';

abstract class AgentsState {
  const AgentsState();

  // @override
  // List<Object> get props => [];
}

class AgentsInProgressState extends AgentsState {}

class AgentsInitialState extends AgentsState {}

class AgentsFailureState extends AgentsState {
  final String errorMessage;
  const AgentsFailureState({this.errorMessage});
}

class AgentsSuccessState extends AgentsState {
  final AgentsToBuyCoins agentsToBuyCoins;

  const AgentsSuccessState({this.agentsToBuyCoins});
}
