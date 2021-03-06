import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_generator/presentation/bloc/category/category_event.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/bloc/category/drinks/drinks_category_bloc.dart';
import 'package:meal_generator/presentation/bloc/category/main/main_category_cubit.dart';
import 'package:meal_generator/presentation/bloc/category/meals/meals_category_bloc.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';
import 'package:meal_generator/presentation/models/ui_meals_category.dart';
import 'package:mocktail/mocktail.dart';

class MockMealsCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements MealsCategoryBloc {}

class MockDrinksCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements DrinksCategoryBloc {}

void main() {
  group('Main Category Cubit', () {
    late MockMealsCategoryBloc _mealsBloc;
    late MockDrinksCategoryBloc _drinksBloc;
    late MainCategoryCubit _mainCategoryCubit;

    // Need to register fallback value for Bloc's Event/State if project is using null safety
    // https://github.com/felangel/bloc/issues/2233
    setUpAll(() {
      registerFallbackValue(CategoryLoading());
      registerFallbackValue(CategoryInitialLoad());
      registerFallbackValue(CategoryLoading());
      registerFallbackValue(CategoryInitialLoad());
    });

    setUp(() {
      _mealsBloc = MockMealsCategoryBloc();
      _drinksBloc = MockDrinksCategoryBloc();
      _mainCategoryCubit =
          MainCategoryCubit(mealsCategoryBloc: _mealsBloc, drinksCategoryBloc: _drinksBloc);
    });

    test('When it is loading, disable Floating Action Button', () {
      whenListen(_mealsBloc, Stream.fromIterable([CategoryLoading()]));
      whenListen(_drinksBloc, Stream.fromIterable([CategoryLoading()]));
      expect(_mainCategoryCubit.userHasChosenMealsAndDrinks(), emits(false));
    });

    var mockedMealCategoryList = [
      UiMealsCategory(
          id: '1',
          name: 'Food',
          thumbnailUrl: 'food.jpg',
          description: 'Food Description',
          isSelected: true)
    ];

    var mockedDrinkCategoryList = [UiDrinksCategory(name: 'Drink', isSelected: true)];

    test('When both meal and drink are selected, enable Floating Action Button', () {
      whenListen(
          _mealsBloc, Stream.fromIterable([CategorySelected(mockedMealCategoryList)]));
      whenListen(
          _drinksBloc, Stream.fromIterable([CategorySelected(mockedDrinkCategoryList)]));

      expect(_mainCategoryCubit.userHasChosenMealsAndDrinks(), emits(true));
    });

    test('When both meal and drink are not selected, disable Floating Action Button', () {
      whenListen(
          _mealsBloc, Stream.fromIterable([CategoryUnselected(mockedMealCategoryList)]));
      whenListen(_drinksBloc,
          Stream.fromIterable([CategoryUnselected(mockedDrinkCategoryList)]));

      expect(_mainCategoryCubit.userHasChosenMealsAndDrinks(), emits(false));
    });

    test('When meal is selected but drink is not selected, disable Floating Action Button', () {
      whenListen(
          _mealsBloc, Stream.fromIterable([CategorySelected(mockedMealCategoryList)]));
      whenListen(
          _drinksBloc, Stream.fromIterable([CategoryUnselected(mockedDrinkCategoryList)]));

      expect(_mainCategoryCubit.userHasChosenMealsAndDrinks(), emits(false));
    });

    test('When drink is selected but meal is not selected, disable Floating Action Button', () {
      whenListen(
          _mealsBloc, Stream.fromIterable([CategoryUnselected(mockedMealCategoryList)]));
      whenListen(
          _drinksBloc, Stream.fromIterable([CategorySelected(mockedDrinkCategoryList)]));

      expect(_mainCategoryCubit.userHasChosenMealsAndDrinks(), emits(false));
    });
  });
}
