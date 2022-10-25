import 'dart:convert';

import '../../domain/entities/char_entity.dart';

class CharModel extends Char {
  const CharModel({
    required String name,
    required String description,
    required String imageUrl,
    List<Char>? relatedHeroes,
  }) : super(
          description: description,
          imageUrl: imageUrl,
          name: name,
          relatedHeroes: relatedHeroes,
        );

  Char toEntity() {
    return Char(
      description: description,
      imageUrl: imageUrl,
      name: name,
      relatedHeroes: relatedHeroes,
    );
  }

  factory CharModel.fromEntity({required Char heroe}) {
    return CharModel(
      name: heroe.name,
      description: heroe.description,
      imageUrl: heroe.imageUrl,
      relatedHeroes: heroe.relatedHeroes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'relatedHeroes': relatedHeroes,
    };
  }

  factory CharModel.fromMap(Map<String, dynamic> map) {
    return CharModel(
      name: map['name'],
      description: map['description'],
      imageUrl: map['thumbnail']['path'] + '.' + map['thumbnail']['extension'],
      relatedHeroes: map['relatedHeroes'] != null
          ? List<CharModel>.from(
              map['relatedHeroes']?.map(
                (x) => CharModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharModel.fromJson(String source) =>
      CharModel.fromMap(json.decode(source));
}
