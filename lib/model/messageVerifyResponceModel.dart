class MessageVerifyResponceModel {
  String firstName;
  String lastName;
  int resultId;
  String resultPath;
  String dateOfCollection;
  String statusProcessingToValedate;

  MessageVerifyResponceModel(
      {this.firstName,
      this.lastName,
      this.resultId,
      this.resultPath,
      this.dateOfCollection,
      this.statusProcessingToValedate});

  MessageVerifyResponceModel.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    resultId = json['ResultId'];
    resultPath = json['ResultPath'];
    dateOfCollection = json['DateOfCollection'];
    statusProcessingToValedate = json['StatusProcessingToValedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['ResultId'] = this.resultId;
    data['ResultPath'] = this.resultPath;
    data['DateOfCollection'] = this.dateOfCollection;
    data['StatusProcessingToValedate'] = this.statusProcessingToValedate;
    return data;
  }
}