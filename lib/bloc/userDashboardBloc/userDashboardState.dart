import 'package:locteca/model/userDashboard.dart';



abstract class UserDashboardState {
  const UserDashboardState();

  // @override
  // List<Object> get props => [];
}

class UserDashboardInProgressState extends UserDashboardState {}

class UserDashboardInitialState extends UserDashboardState {}

class UserDashboardFailureState extends UserDashboardState {
  final String errorMessage;
  const UserDashboardFailureState({this.errorMessage});
}

class UserDashboardSuccessState extends UserDashboardState {
  final UserDashboard userDashboard;

  const UserDashboardSuccessState({this.userDashboard});
}
