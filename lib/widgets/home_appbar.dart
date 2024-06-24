import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/colors.dart';

class HomeappBar extends StatelessWidget {
  final void Function()? onTap;
  const HomeappBar({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'lib/assets/logo.png',
        height: 50,
        width: 120,
      ),
      actions: [
        InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.search,
            color: white,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 27,
              width: 27,
              color: Colors.blue,
            ),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }
}
