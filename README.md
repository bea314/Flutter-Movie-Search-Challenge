# MOVIE SEARCH APPLICATION CHALLENGE
> Created by Beatriz Del Pinal.
>> Flutter version: (stable / 3.32.2 / 8defaa71a7)

This application allows users to search for movies by title using the OMDb API, display organized search results, and view detailed information for each selected movie,
This project will use:
- **BLoC**  
- **Clean Code Architecture**  
- **Error Handling**


## Folder Structure

The project follows a Clean Code Architecture with separation of responsibilities into **data**, **logic**, and **views** layers.

```text
lib/
├── core/                          # Shared code
│   ├── config/                    # ApiConfig, constants
│   ├── error/                     # Failure, Exception
│   ├── network/                   # NetworkInfo, interceptors
│   └── usecases/                  # Generic UseCase interface
│
├── features/                      # Functional modules
│   └── movies/                    # Movies feature
│       ├── data/                  # Infrastructure: HTTP, JSON, repo impl. 
│       │   ├── datasources/       
│       │   ├── models/            
│       │   └── repositories/      
│       │
│       ├── logic/                 # Business logic
│       │   ├── entities/          
│       │   ├── repositories/      
│       │   └── usecases/          
│       │
│       └── views/                 # UI + state (BLoC)
│           ├── bloc/              
│           ├── screens/           
│           └── widgets/           
│
└── main.dart                      # Entry point and routing
```

## Resolution Steps

1. **Project scaffold & README**  
   Initialized the Flutter project, set up `pubspec.yaml`, created the folder structure and wrote the initial README with Clean Code Architecture overview.

2. **Environment configuration**  
   Added `.env` support for the OMDb API key using `flutter_dotenv` and secured that key outside of source control.
   Easily allowing anyone to implement the API key on `.env`.

3. **Basic search UI**  
   Built the raw search screen with a text field and placeholder results to plan the interaction.

4. **Data models & error parsing**  
   Defined `MovieModel`, `MovieDetailModel` and response wrappers; added logic to throw on `"Response": "False"` so OMDb error messages surface.

5. **Detail view UI**  
   Created the detail screen layout and wired up a hero animation for poster transitions.

6. **Search integration with BLoC**  
   Implemented the search flow: DataSource → Repository → UseCase → `MovieSearchBloc` → SearchScreen, displaying live search results.

7. **Filter drawer UI & logic**  
   Introduced `FilterDrawer` with media‐type chips (single‐select) and a validated 4‐digit year input.

8. **Persisting filter state**  
   Stored the selected type and year in the parent screen state so the drawer reopens with the last choices.

9. **Detail integration & mapping fix**  
   Expanded the domain entity to include all OMDb fields, corrected repository mapping, and displayed full detail data.

10. **Error handling & UI feedback**  
    Captured OMDb’s exact error strings (e.g. “Too many results,” “Movie not found!”) and showed them via a bottom sheet.

11. **Pagination attempt & decision**  
    Experimented with infinite‐scroll pagination in the BLoC, but OMDb’s API limits and large‐query behavior made it unnecessary—results always returned in a single restricted page.

12. **Final polish**  
    Tweaked styling, improved responsiveness, and ensured robust state management before final review.


### Search Flow Explained

The movie search feature follows a unidirectional flow through five layers:

1. **DataSource**  
   - **Responsibility**: Makes the raw HTTP call to OMDb using Dio.  
   - **How it works**:  
     ```dart
     final response = await dio.get('/', queryParameters: {
       's': query,
       'page': page.toString(),
       if (type != null) 'type': type,
       if (year != null) 'y': year,
     });
     if (response.data['Response'] == 'False') {
       throw Exception(response.data['Error']);
     }
     final list = response.data['Search'] as List<dynamic>;
     return list.map((json) => MovieModel.fromMap(json)).toList();
     ```

2. **Repository**  
   - **Responsibility**: Converts the DTOs from the DataSource into domain entities (`Movie`).  
   - **How it works**:  
     ```dart
     final dtos = await remote.searchMoviesApi(query: query, type: type, year: year, page: page);
     return dtos.map((m) => Movie(
       imdbId:   m.imdbId,
       title:    m.title,
       year:     m.year,
       posterUrl:m.poster,
     )).toList();
     ```

3. **UseCase**  
   - **Responsibility**: Encapsulates the business operation “search movies” and keeps the repository interface stable.  
   - **How it works**:  
     ```dart
     class SearchMovies {
       final MovieRepository repo;
       SearchMovies(this.repo);
       Future<List<Movie>> call({
         required String query,
         String? type,
         String? year,
         int page = 1,
       }) => repo.searchMovies(
         query: query, type: type, year: year, page: page
       );
     }
     ```

4. **MovieSearchBloc**  
   - **Responsibility**: Manages UI state (initial, loading, loaded, error) and responds to `SearchRequested` events.  
   - **How it works**:  
     ```dart
     on<SearchRequested>((event, emit) async {
       emit(MovieSearchLoading());
       try {
         final movies = await _searchMovies(
           query: event.query,
           type:  event.types.isNotEmpty ? event.types.first.value : null,
           year:  event.year,
           page:  event.page,
         );
         emit(MovieSearchLoaded(movies));
       } catch (e) {
         emit(MovieSearchError(e.toString()));
       }
     });
     ```

5. **SearchScreen**  
   - **Responsibility**: Presents the search UI, dispatches events, and rebuilds when the BLoC state changes.  
   - **How it works**:  
     ```dart
     // User taps “Search” or submits text:
     context.read<MovieSearchBloc>().add(
       SearchRequested(
         _controller.text.trim(),
         types: _activeTypes,
         year:  _activeYear,
         page:  1,
       ),
     );

     // UI rebuild with BlocConsumer or BlocBuilder:
     BlocConsumer<MovieSearchBloc, MovieSearchState>(
       listener: (ctx, state) { /* show errors */ },
       builder: (ctx, state) {
         if (state is MovieSearchLoading) return CircularProgressIndicator();
         if (state is MovieSearchLoaded) return GridView(..., items: state.movies);
         if (state is MovieSearchError)   return Text(state.message);
         return SizedBox.shrink();
       },
     );
     ```

Each layer has a single responsibility, making the code easy to test, maintain, and extend (e.g. adding filters or pagination).
