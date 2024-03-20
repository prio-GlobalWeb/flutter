import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

@JsonSerializable()
class Node {
  final String id;
  final int product_id;
  final int company_id;
  final String manufacturer;
  final String setup_location;
  final DateTime setup_datetime;
  final DateTime scheduled_inspection_date;
  final DateTime registration_datetime;

  Node({
    required this.id,
    required this.product_id,
    required this.company_id,
    required this.manufacturer,
    required this.setup_location,
    required this.setup_datetime,
    required this.scheduled_inspection_date,
    required this.registration_datetime,
  });


  //flutter pub run build_runner build 터미널에 입력
  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json); // 역직렬화
  Map<String, dynamic> toJson() => _$NodeToJson(this); // 직렬화
}