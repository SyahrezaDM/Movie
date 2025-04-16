import 'package:flutter/material.dart';
import 'api_service.dart';
import 'model/media_model.dart';
import 'api_service.dart';

class MovieTab extends StatelessWidget {
  const MovieTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MediaItem>>(
      future: ApiService.fetchPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No movies found.'));
        }

        final movies = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '$imageUrl${movie.posterPath}',
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
