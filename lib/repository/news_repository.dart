import 'dart:convert';

import 'package:device_daily/models/categories_news_model.dart';
import 'package:device_daily/models/news_channels_headlines_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> getNewsChannelsHeadlinesApi(
      String source) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=06770553e2af4d4fa19bcedb00373c69';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {}
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return NewsChannelsHeadlinesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String source) async {
    String url =
        'https://newsapi.org/v2/everything?q=$source&apiKey=06770553e2af4d4fa19bcedb00373c69';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {}
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return CategoriesNewsModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }
}
