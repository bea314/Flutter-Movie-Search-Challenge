import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import '../../data/models/movie_response_model.dart';
import '../widgets/drawer_filter.dart';
import '../widgets/modal_error_bottom_sheet.dart';
import '../widgets/movie_list_item.dart';

MovieResponseModel testData = MovieResponseModel(
  totalResults: '1',
  response: 'True',
  movies: [
    MovieModel.fromMap({
            "Title": "Eva",
            "Year": "2011",
            "imdbID": "tt1298554",
            "Type": "movie",
            "Poster": "https://m.media-amazon.com/images/M/MV5BNDZmY2YyYTktZTRiNS00OTJlLWJlOWUtNjk3MjgxZGM3NjIxXkEyXkFqcGc@._V1_SX300.jpg"
        }),
    MovieModel.fromMap({
            "Title": "Eva & Adam",
            "Year": "1999–2001",
            "imdbID": "tt0136638",
            "Type": "series",
            "Poster": "https://m.media-amazon.com/images/M/MV5BMWMwMjA4M2ItYmFlNS00NGQxLWI0OWYtYzQzYTRhMTdiYjhiXkEyXkFqcGc@._V1_SX300.jpg"
        },),
    MovieModel.fromMap({
            "Title": "The Deflowering of Eva van End",
            "Year": "2012",
            "imdbID": "tt2323264",
            "Type": "movie",
            "Poster": "https://m.media-amazon.com/images/M/MV5BMjE0MTc5OTA0OF5BMl5BanBnXkFtZTcwMzg4NDc4OA@@._V1_SX300.jpg"
        },),
    MovieModel.fromMap({
            "Title": "Eva",
            "Year": "2021",
            "imdbID": "tt16757252",
            "Type": "movie",
            "Poster": "https://m.media-amazon.com/images/M/MV5BYjlhYmE5MGUtYWIzMi00NzAyLWI4NTktOGI5ZGRlN2FjNzg5XkEyXkFqcGc@._V1_SX300.jpg"
        },),
  ],
);

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
        actionLabel: 'ok',
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final posterMinWidth =
        (MediaQuery.of(context).size.width < 600) ? 150.0 : 250.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final columnCount = screenWidth ~/ posterMinWidth;
    final posterWidth = screenWidth / columnCount;
    return Scaffold(
      key: _scaffoldKey,
      drawer: FilterDrawer(
        onApply: (type, year) {
          // TODO: Apply filters
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Search by movie title',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) {
                          // TODO: call search action
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.display_settings),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    const SizedBox(width: 2),
                    IconButton(
                      icon: Icon(Icons.search),
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
                child: Text('Search Random Movie'),
              ),

              if (testData.movies.isNotEmpty) ...[
                SizedBox(height: 36.0),
                // Results list
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnCount,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: testData.movies.length,
                    itemBuilder: (context, index) {
                      final movie = testData.movies[index];
                      return MovieListItem(
                        size: posterWidth,
                        title: movie.title,
                        posterUrl: movie.poster,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: movie.imdbId,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
