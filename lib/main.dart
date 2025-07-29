import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/movies/views/bloc/movie_detail_bloc.dart';
import 'features/movies/views/bloc/movie_detail_event.dart';
import 'features/movies/views/bloc/movie_search_bloc.dart';
import 'features/movies/views/screens/screens.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Movie App',
        initialRoute: '/',
        routes: {
          '/': (ctx) => BlocProvider(
            create: (_) => di.sl<MovieSearchBloc>(),
            child: SearchScreen(),
          ),
          '/details': (context) {
            final movieId = ModalRoute.of(context)!.settings.arguments as String;
            return BlocProvider<MovieDetailBloc>(
              create: (_) => di.sl<MovieDetailBloc>()
                ..add(DetailRequested(movieId)),
              child: DetailScreen(id: movieId),
            );
          },
        },
      ),
    );
  }
}