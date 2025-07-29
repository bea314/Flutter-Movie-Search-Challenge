import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_search_bloc.dart';
import '../bloc/movie_search_event.dart';
import '../bloc/movie_search_state.dart';
import '../widgets/drawer_filter.dart';
import '../widgets/modal_error_bottom_sheet.dart';
import '../widgets/movie_list_item.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _controller = TextEditingController();

    void _onSearch(BuildContext context) async {
      final query = _controller.text.trim();
    print('Searching for: $query');
      if (query.isEmpty) {
        ErrorBottomSheet.show(
          context,
          title: 'Warning',
          message: 'Please enter a movie title to search.',
          actionLabel: 'OK',
        );
      } else {
        // Dispatch the event
        context.read<MovieSearchBloc>().add(
              SearchRequested(query),
            );
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: FilterDrawer(
        onApply: (types, year) {
          context.read<MovieSearchBloc>().add(
            SearchRequested(
              _controller.text.trim(),
              types: types,
              year:  year,
            ),
          );
        },
      ),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Search by movie title',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _onSearch(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.display_settings),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  const SizedBox(width: 2),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _onSearch(context),
                  ),
                ],
              ),
            ),
              SizedBox(height: 36.0),
            TextButton(
              onPressed: () {
                  // TODO: call search action
              },
              child: const Text('Search Random Movie'),
            ),

            BlocConsumer<MovieSearchBloc, MovieSearchState>(
              listener: (ctx, state) {
                if (state is MovieSearchError) {
                  ErrorBottomSheet.show(
                    context,
                    title: 'Error',
                    message: state.message,
                    actionLabel: 'OK',
                  );
                }
              },
              builder: (ctx, state) {
                if (state is MovieSearchInitial) {
                  return const SizedBox.shrink();
                } else if (state is MovieSearchLoading) {
                  return Expanded(child: const Center(child: CircularProgressIndicator()));
                } else if (state is MovieSearchLoaded) {
                  final movies = state.movies;
                  if (movies.isEmpty) {
                    return Expanded(child: const Center(child: Text('No results found.')));
                  }
                  // grid layout
                  final screenWidth = MediaQuery.of(context).size.width;
                  final count = screenWidth ~/ 150;
                  final tileWidth = screenWidth / count;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: count,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (_, i) {
                        final m = movies[i];
                        return Hero(
                          tag: m.imdbId,
                          child: MovieListItem(
                            size: tileWidth,
                            title: m.title,
                            posterUrl: m.posterUrl,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: m.imdbId,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                // fallback
                return const SizedBox.shrink();
              },
            ),
          ],
          ),
        ),
      ),
    );
  }
}
