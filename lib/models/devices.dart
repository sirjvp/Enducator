part of 'models.dart';

class Devices extends Equatable{
  final String deviceId;
  final String deviceName;
  final int deviceWatt;
  final int deviceQuantity;
  final int deviceDay;
  final double deviceTime;
  final String deviceImage;
  final String addBy;
  final String createdAt;
  final String updatedAt;

  Devices(
    this.deviceId,
    this.deviceName,
    this.deviceWatt,
    this.deviceQuantity,
    this.deviceDay,
    this.deviceTime,
    this.deviceImage,
    this.addBy,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
    deviceId,
    deviceName,
    deviceWatt,
    deviceQuantity,
    deviceDay,
    deviceTime,
    deviceImage,
    addBy,
    createdAt,
    updatedAt,
  ];
}