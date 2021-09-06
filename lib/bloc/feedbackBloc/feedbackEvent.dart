abstract class FeedbackEvent {
  // @override
  // List<Object> get props => [];
}

class PostFeedbackEvent extends FeedbackEvent {

final String body;
final String type;
  PostFeedbackEvent({this.body,this.type});
}
