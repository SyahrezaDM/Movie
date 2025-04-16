import 'package:flutter/material.dart';
import 'api_service.dart';
import 'model/media_model.dart';
import 'api_service.dart';

class TvTab extends StatelessWidget {
  const TvTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MediaItem>>(
      future: ApiService.fetchPopularTv(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No TV series found.'));
        }

        final tvSeries = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: tvSeries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final tv = tvSeries[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '$imageUrl${tv.posterPath}',
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
