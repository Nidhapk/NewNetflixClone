import 'package:flutter/material.dart';
import 'package:newnetflixclone/common/colors.dart';

class TextStyles {
  static const TextStyle homePageTitle = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static TextStyle searchText = const TextStyle(
    color: white,
  );
  static const TextStyle detailPageTitle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static const TextStyle detailPageSubTitle = TextStyle(color: kGrey);
  static const TextStyle hnDayStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 5);
  static const TextStyle overViewstyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: kGrey,
    overflow: TextOverflow.ellipsis,
  );
}
