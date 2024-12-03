import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/presentation/home_screen/widgets/tabs/home_tab/widgets/movieDetailsPage.dart';

import '../../../../../api/api_manager/api_manager.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Movies Container
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Popular Movies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          PopularMoviesContainer(),

          SizedBox(height: 20),

          // Upcoming Movies Container
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Upcoming Movies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          UpcomingMoviesContainer(),

          SizedBox(height: 20),

          // Top Rated Movies Container
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Top Rated Movies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          TopRatedMoviesContainer(),
        ],
      ),
    );
  }
}

class PopularMoviesContainer extends StatefulWidget {
  @override
  _PopularMoviesContainerState createState() => _PopularMoviesContainerState();
}

class _PopularMoviesContainerState extends State<PopularMoviesContainer> {
  final ApiManager apiManager = ApiManager();
  List<dynamic> popularMovies = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  void fetchPopularMovies() async {
    final results = await apiManager.getPopularMovies();
    setState(() {
      popularMovies = results;
    });

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (popularMovies.isNotEmpty) {
        setState(() {
          currentIndex = (currentIndex + 1) % popularMovies.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Adjust height as per your needs
      child: popularMovies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              itemCount: popularMovies.length,
              controller: PageController(initialPage: currentIndex),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                var movie = popularMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsPage(movieId: movie['id']),
                      ),
                    );
                  },
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}

class UpcomingMoviesContainer extends StatefulWidget {
  @override
  _UpcomingMoviesContainerState createState() =>
      _UpcomingMoviesContainerState();
}

class _UpcomingMoviesContainerState extends State<UpcomingMoviesContainer> {
  final ApiManager apiManager = ApiManager();
  List<dynamic> upcomingMovies = [];

  @override
  void initState() {
    super.initState();
    fetchUpcomingMovies();
  }

  void fetchUpcomingMovies() async {
    final results = await apiManager.getUpcomingMovies();
    setState(() {
      upcomingMovies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust height as per your needs
      child: upcomingMovies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingMovies.length,
              itemBuilder: (context, index) {
                var movie = upcomingMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsPage(movieId: movie['id']),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          width: 120,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          movie['title'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class TopRatedMoviesContainer extends StatefulWidget {
  @override
  _TopRatedMoviesContainerState createState() =>
      _TopRatedMoviesContainerState();
}

class _TopRatedMoviesContainerState extends State<TopRatedMoviesContainer> {
  final ApiManager apiManager = ApiManager();
  List<dynamic> topRatedMovies = [];

  @override
  void initState() {
    super.initState();
    fetchTopRatedMovies();
  }

  void fetchTopRatedMovies() async {
    final results = await apiManager.getTopRatedMovies();
    setState(() {
      topRatedMovies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust height as per your needs
      child: topRatedMovies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topRatedMovies.length,
              itemBuilder: (context, index) {
                var movie = topRatedMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsPage(movieId: movie['id']),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          width: 120,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          movie['title'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
