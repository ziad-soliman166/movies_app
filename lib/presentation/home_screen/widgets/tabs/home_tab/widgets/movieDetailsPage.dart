import 'package:flutter/material.dart';

import '../../../../../../api/api_manager/api_manager.dart';
import '../../../../../../api/sources/movie_Discover/MovieDiscover_Results.dart';
// Import your movie model (e.g., MovieDiscoverResults)

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  // Constructor accepting movieId
  MovieDetailsPage({required this.movieId});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final ApiManager apiManager = ApiManager();
  late Future<MovieDiscoverResults> movieDetails;

  @override
  void initState() {
    super.initState();
    // Fetch movie details when the page loads
    movieDetails = apiManager.getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: FutureBuilder<MovieDiscoverResults>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No details found for this movie.'));
          }

          MovieDiscoverResults movie = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster Image
                Center(
                  child: Image.network(
                    movie.getPosterImageUrl(),
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                // Movie Title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.title ?? 'Unknown Title',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Movie Overview
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.overview ?? 'No overview available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // Movie Release Date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Release Date: ${movie.releaseDate ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // Movie Vote Average
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rating: ${movie.getRating()} / 10',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // Movie Genres (optional)
                if (movie.genreIds != null && movie.genreIds!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Genres: ${movie.genreIds!.join(', ')}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
