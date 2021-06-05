part of 'models.dart';

class Calculate extends Equatable{
  final String reportId;
  final int totalDevice;
  final double totalWatt;
  final double price;
  final String time;
  final String createdAt;
  final String updatedAt;

  Calculate(
    this.reportId,
    this.totalDevice,
    this.totalWatt,
    this.price,
    this.time,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
    reportId,
    totalDevice,
    totalWatt,
    price,
    time,
    createdAt,
    updatedAt,
  ];
}