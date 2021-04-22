import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:locteca/bloc/userDashboardBloc/userDashboardEvent.dart';
import 'package:locteca/bloc/userDashboardBloc/userDashboardState.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:locteca/repository/userDashboardRepository.dart';

class UserDashboardBloc extends Bloc<UserDashboardEvent, UserDashboardState> {
  UserDashboardRepository userDashboardRepository = UserDashboardRepository();

  UserDashboardBloc();

  @override
  UserDashboardState get initialState => UserDashboardInitialState();

  @override
  Stream<UserDashboardState> mapEventToState(UserDashboardEvent event) async* {
    //final currentState = state;

    if (event is GetUserDashboardDataEvent) {
      try {
        yield UserDashboardInProgressState();

        final userDashboardData =
            await userDashboardRepository.getUserDashboardData();

        if (userDashboardData.response == "true") {
          yield UserDashboardSuccessState(userDashboard: userDashboardData);
        } else {
          yield UserDashboardFailureState(
              errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield UserDashboardFailureState(
            errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
