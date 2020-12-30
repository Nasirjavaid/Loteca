class CheckRecordModel {
  String message;
  String code;
  String result;

  CheckRecordModel({this.message, this.code, this.result});

  CheckRecordModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    code = json['Code'];
    result = json['Result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Code'] = this.code;
    data['Result'] = this.result;
    return data;
  }
}