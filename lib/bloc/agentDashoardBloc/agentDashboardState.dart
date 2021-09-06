import 'package:locteca/model/agentDashboardModel.dart';



abstract class AgentDashboardState {
  const AgentDashboardState();

  // @override
  // List<Object> get props => [];
}

class AgentDashboardInProgressState extends AgentDashboardState {}

class AgentDashboardInitialState extends AgentDashboardState {}

class AgentDashboardFailureState extends AgentDashboardState {
  final String errorMessage;
  const AgentDashboardFailureState({this.errorMessage});
}

class AgentDashboardSuccessState extends AgentDashboardState {
  final AgentDashboardModel agentDashboardModel;

  const AgentDashboardSuccessState({this.agentDashboardModel});
}
