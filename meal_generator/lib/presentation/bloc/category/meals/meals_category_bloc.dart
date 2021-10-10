import 'package:meal_generator/core/api/meals/models/meals_list.dart';
import 'package:meal_generator/core/repository/meals/meals_repository.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/bloc/category/i_category_bloc.dart';
import 'package:meal_generator/presentation/models/ui_meals_category.dart';

class MealsCategoryBloc extends ICategoryBloc<UiMealsCategory,Meals> {
  MealsCategoryBloc(MealsRepository mealsRepository) : super(mealsRepository);

  @override
  CategoryState itemClicked(UiMealsCategory clickedItem, List<UiMealsCategory> oldList) {
    // Toggles the state of the item clicked to Selected/Unselected
    bool toggledState = !clickedItem.isSelected;
    var newList = oldList
        .map((it) => UiMealsCategory(
            id: it.id,
            name: it.name,
            thumbnailUrl: it.thumbnailUrl,
            description: it.description,
            isSelected: (it.id == clickedItem.id) ? toggledState : false))
        .toList();

    if (toggledState) {
      return CategorySelected(newList);
    } else {
      return CategoryUnselected(newList);
    }
  }
}
