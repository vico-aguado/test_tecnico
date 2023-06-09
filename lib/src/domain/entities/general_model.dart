// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GeneralData extends Equatable {
  final String? name;
  final String url;

  const GeneralData({
    this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory GeneralData.fromMap(Map<String, dynamic> map) {
    return GeneralData(
      name: (map['name'] ?? '') as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralData.fromJson(String source) =>
      GeneralData.fromMap(json.decode(source) as Map<String, dynamic>);
}
