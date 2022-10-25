import 'package:equatable/equatable.dart';

class Char extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Char>? relatedHeroes;

  const Char({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.relatedHeroes,
  });

  Char copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    List<Char>? relatedHeroes,
  }) {
    return Char(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      relatedHeroes: relatedHeroes ?? this.relatedHeroes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        relatedHeroes,
      ];
}
