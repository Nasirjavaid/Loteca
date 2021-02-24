import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardEvent.dart';
import 'package:locteca/bloc/agentDashoardBloc/agentDashboardState.dart';
import 'package:locteca/repository/agentDashboardRepository.dart';



class AgentDashboardBloc extends Bloc<AgentDashboardEvent, AgentDashboardState> {
  AgentDashBoardRepository agentDashboardRepository = AgentDashBoardRepository();

  AgentDashboardBloc();

  @override
  AgentDashboardState get initialState => AgentDashboardInitialState();

  @override
  Stream<AgentDashboardState> mapEventToState(AgentDashboardEvent event) async* {
    //final currentState = state;

    if (event is GetAgentDashboardDataEvent) {
      try {
        yield AgentDashboardInProgressState();

        final agentDashboardData = await agentDashboardRepository.getAgentDashboardData();

        if (agentDashboardData.response == "true") {
          yield AgentDashboardSuccessState(agentDashboardModel: agentDashboardData);
        } else {
          yield AgentDashboardFailureState(errorMessage: "Something Went Wrong");
        }
      } catch (_) {
        yield AgentDashboardFailureState(errorMessage: "Something Went Wrong");
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
