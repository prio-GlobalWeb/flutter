import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final String node;
  final String time;
  final String data_count;
  final String file_name;
  final String file_data;

  Data({
    required this.node,
    required this.time,
    required this.data_count,
    required this.file_name,
    required this.file_data,
  });


  //flutter pub run build_runner build 터미널에 입력
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json); // 역직렬화
  Map<String, dynamic> toJson() => _$DataToJson(this); // 직렬화
}