// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_coursecode6/enums.dart';
import 'package:riverpod_coursecode6/filmModel.dart';
import 'package:riverpod_coursecode6/filmProvider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Riverpod Course 6',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: const HomePage(),
      ),
    ),
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return FilmsList(
                    provider: allFilmsProvider,
                  );
                case FavoriteStatus.favorite:
                  return FilmsList(
                    provider: favFilmsProvider,
                  );
                case FavoriteStatus.notfavorite:
                  return FilmsList(
                    provider: notFavFilmsProvider,
                  );
              }
            },
          )
        ],
      ),
    );
  }
}

class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsList({required this.provider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          final favoriteIcon = film.isFavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: favoriteIcon,
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFilmsProvider.notifier).update(
                      film,
                      isFavorite,
                    );
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values
              .map(
                (fs) => DropdownMenuItem(
                  value: fs,
                  child: Text(
                    fs.toString().split('.').last,
                  ),
                ),
              )
              .toList(),
          onChanged: (FavoriteStatus? fs) {
            ref
                .read(
                  favoriteStatusProvider.notifier,
                )
                .state = fs!;
          },
        );
      },
    );
  }
}
