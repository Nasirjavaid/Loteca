import 'package:locteca/model/feedback.dart';
import 'package:locteca/service/feedbackService.dart';



class FeedbackRepository {
  Future<Feedback> postFeedback(String body,String type) async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    Feedback feedback = Feedback();
  FeedbackService feedbackService = FeedbackService();

    feedback = await feedbackService.postFeedback(body, type);

    
    return feedback;
  }
}