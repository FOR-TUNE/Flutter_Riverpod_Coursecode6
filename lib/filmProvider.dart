import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_coursecode6/enums.dart';
import 'package:riverpod_coursecode6/filmModel.dart';

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(demoFilms);

  void update(Film film, bool isFavorite) {
    // find a state with a given id,
    // then copy the film with the new favorite state
    // otherwise we use the same fim
    state = state
        .map(
          (newFilm) => newFilm.id == film.id
              ? newFilm.copy(
                  isFav: isFavorite,
                )
              : newFilm,
        )
        .toList();
  }
}

// Now we create a provider, of type State provider
// This provider is gonna keep state of the favorite status which other providers are gonna listen for changes.
final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

// Now a provider that gives us all films.
final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>(
  (_) => FilmsNotifier(),
);
// Now a provider that gives us favorite films.
// Here this is not a stateNotifierProvider, we use a plain provider
// to get only the favorited films on the list
final favFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => film.isFavorite,
      ),
);
// Now we do the same for none favorite films
final notFavFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => !film.isFavorite,
      ),
);
