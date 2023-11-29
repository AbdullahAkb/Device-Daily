import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_daily/view/home_screen.dart';
import 'package:device_daily/view/news_details_screen.dart';
import 'package:device_daily/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd,yy');
  String categoryName = "General";
  List<String> categoriesList = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: height * 0.08,
        title: Text(
          'Categories',
          style: GoogleFonts.merriweather(
              color: const Color.fromARGB(255, 141, 37, 25),
              fontSize: 28,
              fontWeight: FontWeight.w800),
        ),
        elevation: 7,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .02),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              height: height * 0.05,
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: categoriesList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: width * .02),
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              focusColor: null,
                              hoverColor: null,
                              highlightColor: null,
                              splashColor: null,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                categoryName = categoriesList[index];
                                setState(() {});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: categoryName == categoriesList[index]
                                        ? const Color.fromARGB(255, 141, 37, 25)
                                        : const Color.fromARGB(
                                            255, 236, 239, 241),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: Text(
                                    categoriesList[index].toString(),
                                    style: GoogleFonts.lato(
                                        color: categoryName ==
                                                categoriesList[index]
                                            ? const Color(0xFFECEFF1)
                                            : const Color(0xFF8D2519),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(
              thickness: 0.3,
              height: height * 0.03,
            ),
            Expanded(
              child: FutureBuilder(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Color.fromARGB(255, 141, 37, 25),
                        size: 40,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return AnimationLimiter(
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return NewsDetailsScreen(
                                          newsImageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          newsTitle: snapshot
                                              .data!.articles![index].title
                                              .toString(),
                                          newsDate: format.format(dateTime),
                                          newSource: snapshot.data!
                                              .articles![index].source!.name
                                              .toString(),
                                          content: snapshot
                                              .data!.articles![index].author
                                              .toString(),
                                          newsDescription: snapshot.data!
                                              .articles![index].description
                                              .toString(),
                                          newsAuthor: snapshot
                                              .data!.articles![index].author
                                              .toString(),
                                        );
                                      },
                                    ));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(height * .01),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: height * .18,
                                              width: width * .3,
                                              imageUrl: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              placeholder: (context, url) {
                                                return const Center(
                                                    child: spinKit2);
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.redAccent,
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: height * .16,
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 3,
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: Colors.blue,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        format.format(dateTime),
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 15,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
