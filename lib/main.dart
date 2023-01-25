// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        title: const Text('Home Page'),
        centerTitle: true,
      ),
    );
  }
}

class FilmsWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsWidget({required this.provider, Key? key}) : super(key: key);

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
