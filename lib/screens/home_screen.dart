import 'package:flutter/material.dart';
import 'package:newnetflixclone/models/now_playing.dart';
import 'package:newnetflixclone/models/topratedtv.dart';
import 'package:newnetflixclone/models/upcomeing.dart';
import 'package:newnetflixclone/screens/search_screen.dart';
import 'package:newnetflixclone/services/api_services.dart';
import 'package:newnetflixclone/widgets/custom_carousal.dart';
import 'package:newnetflixclone/widgets/home_appbar.dart';
import 'package:newnetflixclone/widgets/movie_cards.dart';
import 'package:newnetflixclone/widgets/now_playing_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomeingMovieModel> upcomeingMovies;
  late Future<NowPayingMovieModel> nowPlayingMovies;
  late Future<TopRatedTvShowsModel> topRated;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    upcomeingMovies = apiServices.getUpcomeingMovies();
    nowPlayingMovies = apiServices.getNowPlayingMovies();
    topRated = apiServices.getTopRatedShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: HomeappBar(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchScreen()));
              },
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: topRated,
                  builder: (contex, snapshott) {
                    if (snapshott.hasData) {
                      return CustomCarousal(data: snapshott.data!);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              SizedBox(
                  height: 220,
                  child: MovieCard(
                      future: upcomeingMovies, titleText: "Upcomeing Movies")),
              const SizedBox(height: 20),
              SizedBox(
                  height: 220,
                  child: NowPlayingCard(
                      future: nowPlayingMovies,
                      titleText: "Now Playing Movies"))
            ],
          ),
        ));
  }
}
