import 'dart:convert';

import 'package:addis_news_app/models/article_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  final String apiKey = "${dotenv.env['API_KEY']}";

  Future<void> getNews() async {
    news.clear();
    

    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${apiKey}";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData["status"] == "ok") {
        for (var element in jsonData["articles"]) {
          if (element["urlToImage"] != null &&
              element["description"] != null &&
              element["title"] != null) {
            news.add(
              ArticleModel(
                title: element["title"],
                description: element["description"],
                urlToImage: element["urlToImage"],
                url: element["url"],
              ),
            );
          }
        }
      }
    }
  }
}
