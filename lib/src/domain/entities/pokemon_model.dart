import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:test_tecnico/src/domain/entities/type_model.dart';

class Pokemon extends Equatable {
  const Pokemon({
    required this.id,
    required this.name,
    this.types,
    this.loaded = false,
    this.isFavourite = false,
    this.imageUrl = '',
  });

  final int id;
  final String name;
  final List<Type>? types;
  final bool loaded;
  final bool isFavourite;
  final String imageUrl;

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    final idTMP = (map['url'] ?? '').toString().split('/');

    return Pokemon(
      id: idTMP.length > 1 ? int.parse(idTMP[6]) : map['id'] as int,
      name: map['name'] as String,
      types: map['types'] != null
          ? List<Type>.from(
              (map['types'] as List<dynamic>).map<Type>(
                (x) => Type.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      imageUrl:
          map['sprites'] != null && map['sprites']['front_default'] != null
              ? map['sprites']['front_default']
              : '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'types': types?.map((x) => x.toMap()).toList(),
      'image_url': imageUrl,
    };
  }

  Pokemon copyWith({
    int? id,
    String? name,
    List<Type>? types,
    bool? loaded,
    bool? isFavourite,
    String? imageUrl,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      types: types ?? this.types,
      loaded: loaded ?? this.loaded,
      isFavourite: isFavourite ?? this.isFavourite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      imageUrl,
    ];
  }
}
