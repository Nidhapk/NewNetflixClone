import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newnetflixclone/common/colors.dart';
import 'package:newnetflixclone/screens/splash_screen.dart';

void main() {
  runApp(const NetFlixClone());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light));
}

class NetFlixClone extends StatelessWidget {
  const NetFlixClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetFlix Clone',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: const TextTheme(
              bodyLarge: TextStyle(color: white, fontSize: 24),
              bodyMedium: TextStyle(color: white, fontSize: 20)),
          scaffoldBackgroundColor: black,
          fontFamily: GoogleFonts.ptSans().fontFamily,
          useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
