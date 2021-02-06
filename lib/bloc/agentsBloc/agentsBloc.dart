import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/agentsBloc/agentsEvent.dart';
import 'package:locteca/bloc/agentsBloc/agentsState.dart';
import 'package:locteca/repository/agentsRepository.dart';


class AgentsBloc extends Bloc<AgentsEvent, AgentsState> {
  AgentsRepository agentsRepository = AgentsRepository();

  AgentsBloc();

  @override
  AgentsState get initialState => AgentsInitialState();

  @override
  Stream<AgentsState> mapEventToState(AgentsEvent event) async* {
    //final currentState = state;

    if (event is GetAgentsListEvent) {
      try {
        yield AgentsInProgressState();

        final agents = await agentsRepository.getAgents();

        if (agents.response == "true") {
          yield AgentsSuccessState(agentsToBuyCoins: agents);
        } else {
          yield AgentsFailureState(errorMessage: "Something Went Wrong");
        }
      } catch (_) {
        yield AgentsFailureState(errorMessage: "Something Went Wrong");
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
