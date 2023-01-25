// ignore_for_file: file_names
import 'package:flutter/material.dart';

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });
  // Now we create a copy function, so that once we favorite a object/film,
  // which will create a same film values but with different favorite value.
  Film copy({
    required bool isFav,
  }) =>
      Film(
        id: id,
        title: title,
        description: description,
        isFavorite: isFav,
      );

  String toNewString() => 'Flim(id: $id, '
      'title: $title, '
      'description: $description, '
      'isFavorite: $isFavorite)';

  // Now we shall implement equality,
  //This is done usually to allow for differentiating each item in the list when fetching from the list.
  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == isFavorite;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          isFavorite,
        ],
      );
}

const demoFilms = [
  Film(
    id: "1",
    title: 'The Shawshank Redemption',
    description: 'Description of The Shawshank Redemption',
    isFavorite: false,
  ),
  Film(
    id: "2",
    title: 'The Godfather',
    description: 'Description of The Godfather',
    isFavorite: false,
  ),
  Film(
    id: "3",
    title: 'The Godfather: Part II',
    description: 'Description of The Godfather: Part II',
    isFavorite: false,
  ),
  Film(
    id: "4",
    title: 'The Dark Knight',
    description: 'Description of The Dark Knight',
    isFavorite: false,
  ),
];
