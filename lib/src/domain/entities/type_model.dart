// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:test_tecnico/src/domain/entities/general_model.dart';

class Type extends Equatable {
  final int slot;
  final GeneralData type;

  const Type({
    required this.slot,
    required this.type,
  });

  @override
  List<Object> get props => [slot, type];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slot': slot,
      'type': type.toMap(),
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      slot: map['slot'] as int,
      type: GeneralData.fromMap(map['type'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) =>
      Type.fromMap(json.decode(source) as Map<String, dynamic>);
}
