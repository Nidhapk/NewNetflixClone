import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/text_style.dart';
import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/popular_movie_search.dart';
import 'package:newnetflixclone/screens/movie_details_screen.dart';

class TopSearchCard extends StatelessWidget {
  final Future<PopularMovieSearch> future;
  final String title;
  // int? id;
  final void Function()? onTap;
  const  TopSearchCard(
      {super.key,
      required this.future,
      required this.title,
      this.onTap,
      //required this.id
      });

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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    title,
                    style: TextStyles.homePageTitle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: data!.length,
                    // padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                    final int  id = data[index].id;
                      return GestureDetector(
                          onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  MovieDetailsScreen(movieId: id,)));
                    },
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Image.network("$imgUrl${data[index].posterPath}"),
                              const SizedBox(width: 20),
                              SizedBox(
                                  width: 240,
                                  child: Text(
                                    data[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                            ],
                          ),
                        ),
                      );
                    })
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
