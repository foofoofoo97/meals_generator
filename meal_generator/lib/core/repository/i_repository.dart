import 'package:dartz/dartz.dart';
import 'package:meal_generator/presentation/models/ui_category.dart';

abstract class IRepository<T extends UiCategory,T2>{
  Future<Either<Exception, List<T>>> getAllCategories();
  Future<Either<Exception, List<T2>>> getAllChoicesByCategory(String categoryName);
 
}