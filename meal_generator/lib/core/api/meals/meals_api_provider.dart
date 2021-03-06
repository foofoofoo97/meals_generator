import 'package:dio/dio.dart';
import 'package:meal_generator/core/api/i_api_provider.dart';
import 'package:meal_generator/core/api/meals/models/meals_list.dart';
import 'package:meal_generator/core/api/meals/models/meals_category_list.dart';
import 'package:meal_generator/core/network/i_network_client.dart';

class MealsApiProvider extends IApiProvider<MealsCategoryList, MealsList>{

  MealsApiProvider(INetworkClient client): super(client);

  @override
  Future<MealsCategoryList> getAllCategories() async {
    try {
      var path = 'categories.php';
      var res = await client.get(path);
      return MealsCategoryList.fromJson(res.data);
    } on DioError catch (exception) {
      throw exception;
    }
  }

  @override
  Future<MealsList> getAllChoicesByCategory(String categoryName) async {
    try {
      var path = 'filter.php';
      var res = await client.get(path, queryParameters: {
        'c': categoryName
      });
      return MealsList.fromJson(res.data);
    } on DioError catch (exception) {
      throw exception;
    }
  }

}