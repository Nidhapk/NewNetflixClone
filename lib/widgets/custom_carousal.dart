import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/utilis.dart';
import 'package:newnetflixclone/models/topratedtv.dart';

class CustomCarousal extends StatelessWidget {
  final TopRatedTvShowsModel data;
  const CustomCarousal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.33 < 300 ? 300 : size.height * 0.33,
      width: size.width,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
                child: Column(
              children: [
                CachedNetworkImage(imageUrl: '$imgUrl$url'),
                const SizedBox(
                  height: 20,
                ),
                Text(data.results[index].name)
              ],
            ));
          },
          options: CarouselOptions(
              height: size.height * 0.33 < 300 ? 300 : size.height * 0.33,
              aspectRatio: 16 / 9,
              reverse: false,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true)),
    );
  }
}
