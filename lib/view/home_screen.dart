import 'package:device_daily/view/categories_screen.dart';
import 'package:device_daily/view/news_details_screen.dart';
import 'package:device_daily/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum FilterList { bbcNews, aryNews, sportBile, bleacher, cnn, alJazeera }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedValue;
  final format = DateFormat('MMMM dd,yy');
  String sourceName = "bbc-news";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CategoriesScreen();
                },
              ));
            },
            icon: const Icon(Icons.apps_rounded)),
        title: Text(
          'Device Daily',
          style: GoogleFonts.merriweather(
              color: const Color.fromARGB(255, 141, 37, 25),
              letterSpacing: .6,
              fontWeight: FontWeight.w700,
              fontSize: 28),
        ),
        centerTitle: true,
        elevation: 7,
        actions: [
          PopupMenuButton(
            initialValue: selectedValue,
            onSelected: (item) {
              if (FilterList.bbcNews.name == item.name) {
                sourceName = "bbc-news";
              }
              if (FilterList.alJazeera.name == item.name) {
                sourceName = "al-jazeera-english";
              }
              if (FilterList.aryNews.name == item.name) {
                sourceName = "ary-news";
              }
              if (FilterList.bleacher.name == item.name) {
                sourceName = "bleacher-report";
              }
              if (FilterList.cnn.name == item.name) {
                sourceName = "cnn";
              }
              if (FilterList.sportBile.name == item.name) {
                sourceName = "the-sport-bible";
              }

              setState(() {});
            },
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text(
                  "BBC News",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text(
                  "ARY News",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text(
                  "CNN News",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: Text(
                  "Al Jazeera News",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.sportBile,
                child: Text(
                  "Sport Bible",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                ),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.bleacher,
                child: Text(
                  "Bleacher Report",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
            height: height * 0.45,
            width: width,
            child: FutureBuilder(
              future: newsViewModel.getNewsChannelsHeadlinesApi(sourceName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SpinKitFadingCircle(
                          color: Color.fromARGB(255, 141, 37, 25),
                          size: 30,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return AnimationLimiter(
                    child: ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
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
                                  child: SizedBox(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: height * 0.9,
                                          width: width * 0.95,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.02),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
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
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          child: Card(
                                            elevation: 5,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              height: height * 0.17,
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.7,
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  SizedBox(
                                                    width: width * 0.7,
                                                    child: Row(
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
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        Text(
                                                            format.format(
                                                                dateTime),
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
                return Container();
              },
            ),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Expanded(
            child: FutureBuilder(
              future: newsViewModel.fetchCategoriesNewsApi("general"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 40,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return AnimationLimiter(
                    child: ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 700),
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
                                          newSource: snapshot
                                              .data!.articles![index].source
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
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(9),
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
                                                      color: Colors.black54,
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
                        }),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.grey,
  size: 20,
);
