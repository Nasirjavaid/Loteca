import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locteca/bloc/feedbackBloc/feedbackEvent.dart';
import 'package:locteca/bloc/feedbackBloc/feedbackState.dart';
import 'package:locteca/repository/feedbackRepository.dart';
import 'package:easy_localization/easy_localization.dart';
class FeedbackBloc extends Bloc<PostFeedbackEvent, FeedbackState> {
  FeedbackRepository feedbackRepository = FeedbackRepository();

  FeedbackBloc();

  @override
  FeedbackState get initialState => FeedbackInitialState();

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    //final currentState = state;

    if (event is PostFeedbackEvent) {
      try {
        yield FeedbackInProgressState();

        final feedback =
            await feedbackRepository.postFeedback(event.body, event.type);

        if (feedback.response == "true") {
          yield FeedbackSuccessState(feedback: feedback);

          await Future.delayed(Duration(seconds: 1));
          yield CloseScreenState();
          await Future.delayed(Duration(seconds: 1));
          yield CloseScreenState();
        } else {
          yield FeedbackFailureState(errorMessage: "Something Went Wrong".tr().toString());
        }
      } catch (_) {
        yield FeedbackFailureState(errorMessage: "Something Went Wrong".tr().toString());
      }
    }

    // bool _hasReachedMax(SalarySlipState state) =>
    //     state is SalarySlipSuccessState && state.hasReachedMax;
  }
}
