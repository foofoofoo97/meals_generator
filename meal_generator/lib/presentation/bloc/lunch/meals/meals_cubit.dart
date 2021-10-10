import 'package:meal_generator/core/api/meals/models/meals_category_list.dart';
import 'package:meal_generator/core/api/meals/models/meals_list.dart';
import 'package:meal_generator/core/repository/meals/meals_repository.dart';
import 'package:meal_generator/presentation/bloc/lunch/i_item_cubit.dart';
import 'package:meal_generator/presentation/models/ui_meals_category.dart';

class MealsCubit extends IItemCubit<UiMealsCategory, Meals> {
  MealsCubit(MealsRepository mealsRepo,String mealsCategory) : super(mealsRepo,mealsCategory);
}
