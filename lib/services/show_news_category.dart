import 'dart:convert';

import 'package:addis_news_app/models/show_news_category_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ShowNewsCategory {
  List<ShowNewsCategoryModel> categories = [];
  final String apiKey = "${dotenv.env['API_KEY']}";

  Future<void> getNewsCategory(String category) async {
    categories.clear();
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=${category}&apiKey=${apiKey}";

    final response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element["title"] != null &&
            element["url"] != null) {
          ShowNewsCategoryModel showNewsCategoryModel = ShowNewsCategoryModel(
            urlToImage: element["urlToImage"],
            description: element["description"],
            title: element["title"],
            url: element["url"],
          );
          categories.add(showNewsCategoryModel);
        }
      });
    }
  }
}
