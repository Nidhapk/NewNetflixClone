import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/colors.dart';
import 'package:newnetflixclone/common/text_style.dart';
import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/movie_details.dart';
import 'package:newnetflixclone/models/movie_recommendation.dart';
import 'package:newnetflixclone/services/api_services.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailsModel> details;
  late Future<MovieRecomendationModel> recommendation;
  @override
  void initState() {
    super.initState();
    fetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: details,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;
                String genre =
                    movie!.genres.map((genre) => genre.name).join(', ');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        '$imgUrl${movie.backdropPath}'.isEmpty
                            ? Image.asset('lib/assets/netflix-nouveau-logo.jpg')
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '$imgUrl${movie.posterPath}'))),
                              ),
                        IconButton(
                            padding: const EdgeInsets.only(top: 30),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: black,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: TextStyles.detailPageTitle,
                          ),
                          Row(
                            children: [
                              Text(
                                movie.releaseDate.year.toString(),
                                style: TextStyles.detailPageSubTitle,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 260,
                                child: Text(
                                  genre,
                                  style: const TextStyle(
                                      fontSize: 17, color: kGrey),
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            movie.overview,
                            style: const TextStyle(color: white, fontSize: 17),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: recommendation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final recommendedMovie = snapshot.data;
                            return recommendedMovie!.results.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text('More like this'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GridView.builder(
                                          itemCount:
                                              recommendedMovie.results.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 15.0,
                                                  crossAxisSpacing: 5,
                                                  childAspectRatio: 1.5 / 2),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieDetailsScreen(
                                                                movieId:
                                                                    recommendedMovie
                                                                        .results[
                                                                            index]
                                                                        .id)));
                                              },
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$imgUrl${recommendedMovie.results[index].posterPath}"),
                                            );
                                          })
                                    ],
                                  );
                          } else {
                            return const SizedBox.shrink();
                          }
                        })
                  ],
                );
              } else {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(100.0),
                  child: CircularProgressIndicator(),
                ));
              }
            }),
      ),
    );
  }

  fetData() {
    details = apiServices.getMovieDetails(widget.movieId);
    recommendation = apiServices.getRecommendedMovie(widget.movieId);
    setState(() {});
  }
}
