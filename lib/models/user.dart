class UserModel{
  final String? userID;
  final String? firstName;
  final String? lastName;
  final String? driverL;
  final String? aadhaarC;
  final bool verified = false;

  UserModel(this.userID, this.firstName, this.lastName, this.driverL, this.aadhaarC);

  Map<String, dynamic> toJson() =>{
    'userID' : userID,
    'First Name' :firstName,
    'Last Name' :lastName,
    'DL number' :driverL,
    'Aadhaar Card Number' :aadhaarC,
    'Verification Status' :false,
  };
}