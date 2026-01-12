import 'package:addis_news_app/models/article_model.dart';
import 'package:addis_news_app/models/category_model.dart';
import 'package:addis_news_app/pages/article_view.dart';
import 'package:addis_news_app/pages/news_category_tile.dart';
import 'package:addis_news_app/services/data.dart';
import 'package:addis_news_app/services/news.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  Future<void> getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 40.0, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Addis",
                          style: TextStyle(
                            color: Color.fromARGB(255, 239, 50, 53),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "News",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Hottest News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.85,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArticleView(blogUrl: articles[index].url),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 3.0,
                                left: 3.0,
                                right: 10.0,
                              ),
                              child: Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(
                                                20.0,
                                              ),

                                          child: Image.network(
                                            articles[index]
                                                    .urlToImage
                                                    .isNotEmpty
                                                ? articles[index].urlToImage
                                                : "https://via.placeholder.com/300x150",
                                            height: 150,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width /
                                                1.8,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(
                                                  Icons.broken_image,
                                                  size: 50,
                                                ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            1.8,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          articles[index].title,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            1.8,
                                        child: Text(
                                          articles[index].description,
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              141,
                                              0,
                                              0,
                                              0,
                                            ),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          width: 80,
                                          height: 43,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                              255,
                                              239,
                                              50,
                                              53,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),

                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Explore",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 150.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return NewsCategoryTile(
                            categoryName: categories[index].categoryName,
                            image: categories[index].image,
                          );
                        },
                      ),
                    ),
                    Text(
                      "Trending News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.85,
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArticleView(blogUrl: articles[index].url),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 15.0,
                                right: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),

                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      articles[index].urlToImage.isNotEmpty
                                          ? articles[index].urlToImage
                                          : "https://via.placeholder.com/130",
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                    ),
                                  ),

                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            1.7,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            articles[index].title,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            1.7,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            articles[index].description,
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                141,
                                                0,
                                                0,
                                                0,
                                              ),
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
