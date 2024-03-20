// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      id: json['id'] as String,
      product_id: json['product_id'] as int,
      company_id: json['company_id'] as int,
      manufacturer: json['manufacturer'] as String,
      setup_location: json['setup_location'] as String,
      setup_datetime: DateTime.parse(json['setup_datetime'] as String),
      scheduled_inspection_date:
          DateTime.parse(json['scheduled_inspection_date'] as String),
      registration_datetime:
          DateTime.parse(json['registration_datetime'] as String),
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.product_id,
      'company_id': instance.company_id,
      'manufacturer': instance.manufacturer,
      'setup_location': instance.setup_location,
      'setup_datetime': instance.setup_datetime.toIso8601String(),
      'scheduled_inspection_date':
          instance.scheduled_inspection_date.toIso8601String(),
      'registration_datetime': instance.registration_datetime.toIso8601String(),
    };
