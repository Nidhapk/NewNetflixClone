import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/colors.dart';
import 'package:newnetflixclone/common/text_style.dart';
import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/popular_movie_search.dart';
import 'package:newnetflixclone/models/search_movie.dart';
import 'package:newnetflixclone/screens/movie_details_screen.dart';
import 'package:newnetflixclone/services/api_services.dart';
import 'package:newnetflixclone/widgets/topsearch_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchMovieModel? searchModel;
  late Future<PopularMovieSearch> popularsearchModel;
  @override
  void initState() {
    super.initState();
    popularsearchModel = apiServices.popularMovieSearch();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              padding: const EdgeInsets.all(10),
              controller: searchController,
              prefixIcon: const Icon(
                Icons.search,
                color: kGrey,
              ),
              suffixIcon: const Icon(
                Icons.cancel,
                color: kGrey,
              ),
              style: TextStyles.searchText,
              backgroundColor: kGrey.withOpacity(0.3),
              onChanged: (value) async {
                if (value.isEmpty) {
                } else {
                  await searchMovie(searchController.text);
                }
              },
            ),
            searchController.text.isEmpty
                ? TopSearchCard(
                    future: popularsearchModel, title: 'Top Searches')
                : searchModel == null
                    ? const SizedBox.shrink()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchModel!.results.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 3.0,
                                childAspectRatio: 1.2 / 2),
                        itemBuilder: (context, index) {
                          return InkWell(onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movieId: searchModel!.results[index].id)));
                          },
                            child: Column(
                              children: [
                                searchModel?.results[index].backdropPath == null
                                    ? Image.asset(
                                        'lib/assets/netflix-nouveau-logo.jpg',
                                        height: 170,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl:
                                            '$imgUrl${searchModel!.results[index].backdropPath}',
                                        height: 170,
                                      ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    searchModel!.results[index].title,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          );
                        })
          ],
        ),
      ),
    ));
  }

  searchMovie(String query) async {
    await apiServices.getMovie(query).then(
      (value) {
        setState(() {
          searchModel = value;
        });
      },
    );
  }
}
