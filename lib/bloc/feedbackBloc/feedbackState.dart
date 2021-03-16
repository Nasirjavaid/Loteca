import 'package:locteca/model/feedback.dart';


abstract class FeedbackState {
  const FeedbackState();

  // @override
  // List<Object> get props => [];
}

class FeedbackInProgressState extends FeedbackState {}

class FeedbackInitialState extends FeedbackState {}
class CloseScreenState extends FeedbackState {}

class FeedbackFailureState extends FeedbackState {
  final String errorMessage;
  const FeedbackFailureState({this.errorMessage});
}

class FeedbackSuccessState extends FeedbackState {
  final Feedback feedback;

  const FeedbackSuccessState({this.feedback});
}
