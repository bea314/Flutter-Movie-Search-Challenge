import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';
import '../widgets/movie_detail_view.dart';
import '../../../../injection_container.dart' as di;  

class DetailScreen extends StatelessWidget {
  final String id;
  final String? poster;
  
  const DetailScreen({
    super.key, 
    required this.id,
    this.poster
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailBloc>(
      create: (_) => di.sl<MovieDetailBloc>()..add(DetailRequested(id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie Detail', textAlign: TextAlign.start,),
        ),
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieDetailLoaded) {
              return MovieDetailView(id: id, movie: state.detail, poster: poster);
            }
            if (state is MovieDetailError) {
              return Center(child: Text(state.message));
            }
            // initial or fallback
            return const SizedBox.shrink();
          }
        ),
      ),
    );
  }
}
