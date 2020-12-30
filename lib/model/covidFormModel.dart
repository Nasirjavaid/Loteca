class CovidFormModel {

  String firstName;
  String lastName;
  String dateOfBirth;
  String dlIdNumber;
  String emailAddress;
  String mobilePhoneNumber;
  String secondaryPhoneNumber;
  String address1;
  String address2;
  String city;
  String state;
  String zipCode;
  String country;
  String sexAssignedAtBirth;
  String hispanicOrLatinoEthnicity;
  String arabEthnicity;
  String race;
  String pregnancy;
  String billingType;
  String exposureToCovid19NoOfDays;
  String signAndSymptomsNoOfDays;
  bool signesAndSymptomsSwitchInnerValueCoughR05;
  bool signesAndSymptomsSwitchInnerValueShortnesOfBreathR06;
  bool signesAndSymptomsSwitchInnerValueFeverUnspecifiedR50;
  bool employerOrAgencyRecomdedTesting;
  String medicalNecessityOther;
  String dateOfOrder;
  String timeOfOrder;
  var signatureBase64ImageData;

  CovidFormModel(
      {this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.dlIdNumber,
      this.emailAddress,
      this.mobilePhoneNumber,
      this.secondaryPhoneNumber,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zipCode,
      this.country,
      this.sexAssignedAtBirth,
      this.hispanicOrLatinoEthnicity,
      this.arabEthnicity,
      this.race,
      this.pregnancy,
      this.billingType,
      this.exposureToCovid19NoOfDays,
      this.signAndSymptomsNoOfDays,
      this.signesAndSymptomsSwitchInnerValueCoughR05,
      this.signesAndSymptomsSwitchInnerValueShortnesOfBreathR06,
      this.signesAndSymptomsSwitchInnerValueFeverUnspecifiedR50,
      this.employerOrAgencyRecomdedTesting,
      this.medicalNecessityOther,
      this.dateOfOrder,
      this.timeOfOrder,
      this.signatureBase64ImageData});

  CovidFormModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    dlIdNumber = json['dlIdNumber'];
    emailAddress = json['emailAddress'];
    mobilePhoneNumber = json['mobilePhoneNumber'];
    secondaryPhoneNumber = json['secondaryPhoneNumber'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    country = json['country'];
    sexAssignedAtBirth = json['sexAssignedAtBirth'];
    hispanicOrLatinoEthnicity = json['hispanicOrLatinoEthnicity'];
    arabEthnicity = json['arabEthnicity'];
    race = json['race'];
    pregnancy = json['pregnancy'];
    billingType = json['billingType'];
    exposureToCovid19NoOfDays = json['exposureToCovid19NoOfDays'];
    signAndSymptomsNoOfDays = json['signAndSymptomsNoOfDays'];
    signesAndSymptomsSwitchInnerValueCoughR05 =
        json['signesAndSymptomsSwitchInnerValueCoughR05'];
    signesAndSymptomsSwitchInnerValueShortnesOfBreathR06 =
        json['signesAndSymptomsSwitchInnerValueShortnesOfBreathR06'];
    signesAndSymptomsSwitchInnerValueFeverUnspecifiedR50 =
        json['signesAndSymptomsSwitchInnerValueFeverUnspecifiedR50'];
    employerOrAgencyRecomdedTesting = json['employerOrAgencyRecomdedTesting'];
    medicalNecessityOther = json['medicalNecessityOther'];
    dateOfOrder = json['dateOfOrder'];
    timeOfOrder = json['timeOfOrder'];
    signatureBase64ImageData = json['signatureBase64ImageData'];

    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['dlIdNumber'] = this.dlIdNumber;
    data['emailAddress'] = this.emailAddress;
    data['mobilePhoneNumber'] = this.mobilePhoneNumber;
    data['secondaryPhoneNumber'] = this.secondaryPhoneNumber;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['country'] = this.country;
    data['sexAssignedAtBirth'] = this.sexAssignedAtBirth;
    data['hispanicOrLatinoEthnicity'] = this.hispanicOrLatinoEthnicity;
    data['arabEthnicity'] = this.arabEthnicity;
    data['race'] = this.race;
    data['pregnancy'] = this.pregnancy;
    data['billingType'] = this.billingType;
    data['exposureToCovid19NoOfDays'] = this.exposureToCovid19NoOfDays;
    data['signAndSymptomsNoOfDays'] = this.signAndSymptomsNoOfDays;
    data['signesAndSymptomsSwitchInnerValueCoughR05'] =
        this.signesAndSymptomsSwitchInnerValueCoughR05;
    data['signesAndSymptomsSwitchInnerValueShortnesOfBreathR06'] =
        this.signesAndSymptomsSwitchInnerValueShortnesOfBreathR06;
    data['signesAndSymptomsSwitchInnerValueFeverUnspecifiedR50'] =
        this.signesAndSymptomsSwitchInnerValueFeverUnspecifiedR50;
    data['employerOrAgencyRecomdedTesting'] =
        this.employerOrAgencyRecomdedTesting;
    data['medicalNecessityOther'] = this.medicalNecessityOther;
    data['dateOfOrder'] = this.dateOfOrder;
    data['timeOfOrder'] = this.timeOfOrder;
    data['signatureBase64ImageData'] = this.signatureBase64ImageData;

    // if (this.data != null) {
    //   data['data'] = this.data.toJson();
    // }
    return data;
  }
}
