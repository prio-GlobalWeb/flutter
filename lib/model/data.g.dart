// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      node: json['node'] as String,
      time: json['time'] as String,
      data_count: json['data_count'] as String,
      file_name: json['file_name'] as String,
      file_data: json['file_data'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'node': instance.node,
      'time': instance.time,
      'data_count': instance.data_count,
      'file_name': instance.file_name,
      'file_data': instance.file_data,
    };
