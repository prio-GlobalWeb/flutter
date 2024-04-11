import 'package:json_annotation/json_annotation.dart';

part 'map_m.g.dart';

@JsonSerializable()
class MapM {
  final String id;
  final String setup_location;
  final double position_x;
  final double position_y;

  MapM({
    required this.id,
    required this.setup_location,
    required this.position_x,
    required this.position_y,
  });


  //flutter pub run build_runner build 터미널에 입력
  factory MapM.fromJson(Map<String, dynamic> json) => _$MapMFromJson(json); // 역직렬화
  Map<String, dynamic> toJson() => _$MapMToJson(this); // 직렬화
}