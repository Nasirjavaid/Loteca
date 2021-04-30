abstract class CoinRecordEvent {
  // @override
  // List<Object> get props => [];
}

class GetCoinRecordEvent extends CoinRecordEvent {}

class GetUserCoinRecordEvent extends CoinRecordEvent {}

class GetRecordReciptDetailsEvent extends CoinRecordEvent {
  final int id;

  final int apiDirectionalCall;
  GetRecordReciptDetailsEvent({this.id,this.apiDirectionalCall});
}


