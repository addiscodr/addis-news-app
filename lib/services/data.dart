import 'package:addis_news_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  return [
    CategoryModel(categoryName: "Business", image: "images/business.jpg"),
    CategoryModel(
      categoryName: "Entertainment",
      image: "images/entertainment.jpg",
    ),

    CategoryModel(categoryName: "Sports", image: "images/sports.jpg"),
    CategoryModel(categoryName: "Technology", image: "images/technology.jpg"),
    CategoryModel(categoryName: "Health", image: "images/health.jpg"),
  ];
}
