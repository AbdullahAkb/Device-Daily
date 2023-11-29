import 'package:device_daily/models/categories_news_model.dart';
import 'package:device_daily/models/news_channels_headlines_model.dart';
import 'package:device_daily/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelsHeadlinesModel> getNewsChannelsHeadlinesApi(
      String source) async {
    final response = await _repo.getNewsChannelsHeadlinesApi(source);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String source) async {
    final response = await _repo.fetchCategoriesNewsApi(source);
    return response;
  }
}
