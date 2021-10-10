import 'package:meal_generator/core/api/drinks/models/drinks_list.dart';
import 'package:meal_generator/core/repository/drinks/drinks_repository.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/bloc/category/i_category_bloc.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';

class DrinksCategoryBloc extends ICategoryBloc<UiDrinksCategory,Drinks> {
  DrinksCategoryBloc(DrinksRepository drinksRepository) : super(drinksRepository);

  @override
  CategoryState itemClicked(UiDrinksCategory clickedItem, List<UiDrinksCategory> oldList) {
    bool toggledState = !clickedItem.isSelected;
    var newList = oldList
        .map((it) => UiDrinksCategory(
        name: it.name,
        isSelected: (it.name == clickedItem.name) ? toggledState : false)
    ).toList();

    if (toggledState) {
      return CategorySelected(newList);
    } else {
      return CategoryUnselected(newList);
    }
  }
}
