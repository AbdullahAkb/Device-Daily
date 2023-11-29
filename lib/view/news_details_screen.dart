import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_daily/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImageUrl,
      newSource,
      newsTitle,
      newsDate,
      newsAuthor,
      newsDescription,
      content;
  const NewsDetailsScreen({
    super.key,
    required this.newsImageUrl,
    required this.newSource,
    required this.newsTitle,
    required this.newsDate,
    required this.newsAuthor,
    required this.newsDescription,
    required this.content,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: height * 0.08,
        title: Text(
          widget.newsAuthor,
          style: GoogleFonts.merriweather(
              color: const Color.fromARGB(255, 141, 37, 25),
              fontSize: 28,
              fontWeight: FontWeight.w800),
        ),
        elevation: 7,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.00),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(seconds: 1),
                childAnimationBuilder: (widget) {
                  return SlideAnimation(
                    duration: const Duration(seconds: 1),
                    verticalOffset: 80.0,
                    child: FadeInAnimation(child: widget),
                  );
                },
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: height * 0.4,
                        width: width,
                        child: ClipRRect(
                          // borderRadius: const BorderRadius.only(
                          //    ),
                          child: CachedNetworkImage(
                            imageUrl: widget.newsImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return const Center(child: spinKit2);
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.6,
                        margin: EdgeInsets.only(top: height * 0.37),
                        padding: EdgeInsets.only(
                            top: height * 0.03,
                            left: width * 0.05,
                            right: width * 0.05),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: ListView(
                          children: [
                            Text(
                              widget.newsTitle,
                              style: GoogleFonts.lato(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.newSource,
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue),
                                  ),
                                ),
                                Text(
                                  widget.newsDate,
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              widget.newsDescription,
                              style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
