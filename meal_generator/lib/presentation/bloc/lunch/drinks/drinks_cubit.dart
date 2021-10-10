import 'package:meal_generator/core/api/drinks/models/drinks_list.dart';
import 'package:meal_generator/core/repository/drinks/drinks_repository.dart';
import 'package:meal_generator/presentation/bloc/lunch/i_item_cubit.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';

class DrinksCubit extends IItemCubit<UiDrinksCategory,Drinks> {
  DrinksCubit(DrinksRepository drinksRepo, String drinksCategory)
      : super(drinksRepo, drinksCategory);
}
