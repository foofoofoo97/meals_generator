import 'package:bloc/bloc.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/bloc/category/drinks/drinks_category_bloc.dart';
import 'package:meal_generator/presentation/bloc/category/main/main_category_state.dart';
import 'package:meal_generator/presentation/bloc/category/meals/meals_category_bloc.dart';
import 'package:meal_generator/presentation/models/ui_category.dart';
import 'package:rxdart/rxdart.dart';

class MainCategoryCubit extends Cubit<MainCategoryState> {
  final MealsCategoryBloc mealsCategoryBloc;
  final DrinksCategoryBloc drinksCategoryBloc;

  Stream<bool> userHasChosenMealsAndDrinks() =>
      Rx.combineLatest2(mealsCategoryBloc.stream, drinksCategoryBloc.stream, (meals, drinks) {
        return meals is CategorySelected && drinks is CategorySelected;
      });

  MainCategoryCubit({required this.mealsCategoryBloc, required this.drinksCategoryBloc})
      : super(MainCategoryState());

  UiCategory? getSelectedMealCategory() {
    var state = mealsCategoryBloc.state;
    if (state is CategorySelected) {
      return state.getSelectedCategory();
    }
    return null;
  }

  UiCategory? getSelectedDrinksCategory() {
    var state = drinksCategoryBloc.state;
    if (state is CategorySelected) {
      return state.getSelectedCategory();
    }
    return null;
  }
}
