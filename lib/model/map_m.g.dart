// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_m.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapM _$MapMFromJson(Map<String, dynamic> json) => MapM(
      id: json['id'] as String,
      setup_location: json['setup_location'] as String,
      position_x: (json['position_x'] as num).toDouble(),
      position_y: (json['position_y'] as num).toDouble(),
    );

Map<String, dynamic> _$MapMToJson(MapM instance) => <String, dynamic>{
      'id': instance.id,
      'setup_location': instance.setup_location,
      'position_x': instance.position_x,
      'position_y': instance.position_y,
    };
