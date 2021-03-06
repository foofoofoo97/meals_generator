import 'package:dartz/dartz.dart';
import 'package:meal_generator/core/api/drinks/drinks_api_provider.dart';
import 'package:meal_generator/core/api/drinks/models/drinks_list.dart';
import 'package:meal_generator/core/mapper/drink_category_mapper.dart';
import 'package:meal_generator/core/repository/i_repository.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';

class DrinksRepository extends IRepository<UiDrinksCategory,Drinks> {

  late DrinksApiProvider _drinksApi;
  late DrinksCategoryMapper _mapper;

  DrinksRepository(this._drinksApi,this._mapper);

  @override
  Future<Either<Exception, List<UiDrinksCategory>>> getAllCategories() async {
    try {
      var result = await _drinksApi.getAllCategories();
      var mappedResult = _mapper.toList(result.categories);

      return Right(mappedResult);

    } on Exception catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Exception, List<Drinks>>> getAllChoicesByCategory(String categoryName) async {
    try {
      var result = await _drinksApi.getAllChoicesByCategory(categoryName);
      return Right(result.list);
    } on Exception catch (exception) {
      return Left(exception);
    }
  }
}