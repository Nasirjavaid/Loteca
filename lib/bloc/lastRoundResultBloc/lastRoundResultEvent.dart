abstract class LastRoundResultEvent {
  // @override
  // List<Object> get props => [];
}

class GetLastRoundResultEvent extends LastRoundResultEvent {}

class GetRoundDetailEvent extends LastRoundResultEvent {
  final int roundId;
  GetRoundDetailEvent({this.roundId});
}
