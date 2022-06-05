class VehicleModel{
  final String? userID;
  final String? vehicleManufacturer;
  final String? vehicleModel;
  final String? vehicleNumber;
  final String? vehicleColor;
  final String? vehicleType;

  VehicleModel(this.userID, this.vehicleManufacturer, this.vehicleModel, this.vehicleNumber, this.vehicleColor, this.vehicleType);

  Map<String, dynamic> toJson() =>{
    'Vehicle Manufacturer' :vehicleManufacturer,
    'Vehicle Model' :vehicleModel,
    'Vehicle Number' :vehicleNumber,
    'Vehicle Color' :vehicleColor,
    'Vehicle Type' :vehicleType
  };
}