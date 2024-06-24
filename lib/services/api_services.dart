import 'dart:convert';
import 'dart:developer';

import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/movie_details.dart';
import 'package:newnetflixclone/models/movie_recommendation.dart';
import 'package:newnetflixclone/models/now_playing.dart';
import 'package:newnetflixclone/models/popular_movie_search.dart';
import 'package:newnetflixclone/models/search_movie.dart';
import 'package:newnetflixclone/models/topratedtv.dart';
import 'package:newnetflixclone/models/trending_movie.dart';
import 'package:newnetflixclone/models/upcomeing.dart';
import 'package:http/http.dart' as http;

var apikey = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomeingMovieModel> getUpcomeingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success1");
      return UpcomeingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcomeing movies");
  }
  
Future<NowPayingMovieModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success2");
      return NowPayingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcomeing movies");
  }
  // Future<NowPayingMovieModel> getNowPlayingMovies() async {
  //   endPoint = "movie/now_playing";
  //   final url = "$baseUrl$endPoint$apiKey";
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     log("Successfulll2");
  //     return NowPayingMovieModel.fromJson(jsonDecode(response.body));
  //   }
  //   throw Exception("Failed to load now playing movies");
  // }

  Future<TopRatedTvShowsModel> getTopRatedShows() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success3");
      return TopRatedTvShowsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcomeing movies");
  }

  Future<SearchMovieModel> getMovie(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOTNlNjZiNDAyNWExMTY2NjdjOWI1OWYzNTllNzYwMCIsInN1YiI6IjY2NzUwN2E0NzhiMzlmNTM4MjcxZTQyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Zo-2XcGpJEwgnROXkU19SLnhF4iUnoREc8JZKoTcOf8"
    });
    if (response.statusCode == 200) {
      log("success4");
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load searched movies");
  }

  Future<PopularMovieSearch> popularMovieSearch() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success5");
      return PopularMovieSearch.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies search");
  }

  Future<MovieDetailsModel> getMovieDetails(int id) async {
    endPoint = "movie/$id";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success6");
      return MovieDetailsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies search");
  }

  Future<MovieRecomendationModel> getRecommendedMovie(int id) async {
    endPoint = "movie/$id/recommendations";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success7");
      return MovieRecomendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies search");
  }

  Future<TrendingMovieModel> getTrending(String time) async {
    endPoint = "trending/movie/$time";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success8");
      return TrendingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies search");
  }
}
