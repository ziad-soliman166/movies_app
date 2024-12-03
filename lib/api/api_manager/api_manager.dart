import 'dart:convert';

import 'package:http/http.dart' as http;

import '../sources/movie_Discover/MovieDiscover_Results.dart';

class ApiManager {
  final String apiKey = 'YOUR_API_KEY';
  final String baseUrl = 'https://api.themoviedb.org/3/';

  // Fetch Popular Movies
  Future<List<MovieDiscoverResults>> getPopularMovies() async {
    final url = '${baseUrl}movie/popular?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var results = data['results'] as List;
      return results
          .map((movie) => MovieDiscoverResults.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  // Fetch Upcoming Movies
  Future<List<MovieDiscoverResults>> getUpcomingMovies() async {
    final url = '${baseUrl}movie/upcoming?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var results = data['results'] as List;
      return results
          .map((movie) => MovieDiscoverResults.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  // Fetch Top Rated Movies
  Future<List<MovieDiscoverResults>> getTopRatedMovies() async {
    final url = '${baseUrl}movie/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var results = data['results'] as List;
      return results
          .map((movie) => MovieDiscoverResults.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  // Fetch Movie Details
  Future<MovieDiscoverResults> getMovieDetails(int movieId) async {
    final url = '${baseUrl}movie/$movieId?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return MovieDiscoverResults.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
