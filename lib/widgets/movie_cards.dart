import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/text_style.dart';
import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/upcomeing.dart';
import 'package:newnetflixclone/screens/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final Future<UpcomeingMovieModel> future;
  final String titleText;
  const MovieCard({super.key, required this.future, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    titleText,
                    style: TextStyles.homePageTitle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data!.length,
                      // padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    movieId: data[index].id)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.network(
                                "$imgUrl${data[index].posterPath}"),
                          ),
                        );
                      }),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
