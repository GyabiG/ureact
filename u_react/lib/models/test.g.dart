// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['tID', 'tName', 'tDate', 'iID'],
  );
  return Test(
    json['tID'] as int,
    json['tName'] as String,
    json['tDate'] as String,
    json['tNotes'] as String?,
    json['baseline'] as int?,
    json['iID'] as int,
    json['staticTest'] == null
        ? null
        : Static.fromJson(json['staticTest'] as Map<String, dynamic>),
    json['reactiveTest'] == null
        ? null
        : Reactive.fromJson(json['reactiveTest'] as Map<String, dynamic>),
    json['dynamicTest'] == null
        ? null
        : Dynamic.fromJson(json['dynamicTest'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'tID': instance.tID,
      'tName': instance.tName,
      'tDate': instance.tDate,
      'iID': instance.iID,
      'tNotes': instance.tNotes,
      'baseline': instance.baseline,
      'staticTest': instance.staticTest,
      'reactiveTest': instance.reactiveTest,
      'dynamicTest': instance.dynamicTest,
    };
