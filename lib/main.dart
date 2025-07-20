import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/movies/views/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
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
          '/': (context) => SearchScreen(),
          '/details': (context) {
            final movieId = ModalRoute.of(context)!.settings.arguments as String;
            return DetailScreen(id: movieId);
          },
        },
      ),
    );
  }
}