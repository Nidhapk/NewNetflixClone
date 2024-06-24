import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/colors.dart';
import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/trending_movie.dart';
import 'package:newnetflixclone/models/upcomeing.dart';
import 'package:newnetflixclone/services/api_services.dart';
import 'package:newnetflixclone/widgets/comeing_soon.dart';

class HotandNew extends StatefulWidget {
  const HotandNew({super.key});

  @override
  State<HotandNew> createState() => _HotandNewState();
}

class _HotandNewState extends State<HotandNew> {
  late Future<TrendingMovieModel> trending;
  late Future<UpcomeingMovieModel> upcomeing;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    trending = apiServices.getTrending('day');
    upcomeing = apiServices.getUpcomeingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "New & Hot",
              style: TextStyle(color: white),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: white,
              ),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              tabs: const [
                Tab(
                  text: "  🔥 Coming Soon  ",
                ),
                Tab(
                  text: "  🍿 Everyone's Watching  ",
                ),
              ],
              labelColor: black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: white,
              dividerColor: black,
              isScrollable: false,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: white),
            ),
          ),
          body: TabBarView(
            children: [
              _buildFutureBuilder1(),
              _buildFutureBuilder2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFutureBuilder1() {
    return FutureBuilder<UpcomeingMovieModel>(
      future: upcomeing,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!.results;
          log(data.length.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ComeingSoonWidget(
                image: '$imgUrl${data[index].backdropPath}',
                overView: data[index].overview,
                logo: '$imgUrl${data[index].posterPath}',
                month: data[index].releaseDate.month.toString(),
                day: data[index].releaseDate.day.toString(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFutureBuilder2() {
    return FutureBuilder<TrendingMovieModel>(
      future: trending,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!.results;
          log(data.length.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ComeingSoonWidget(
                image: '$imgUrl${data[index].backdropPath}',
                overView: data[index].overview,
                logo: '$imgUrl${data[index].posterPath}',
                month: data[index].releaseDate.month.toString(),
                day: data[index].releaseDate.day.toString(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
