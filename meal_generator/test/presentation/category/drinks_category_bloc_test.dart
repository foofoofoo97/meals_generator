import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_generator/presentation/bloc/category/category_event.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/bloc/category/drinks/drinks_category_bloc.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';
import 'package:mockito/mockito.dart';

import '../../shared_mocks.mocks.dart';

void main() {
  var mockDrinksRepository = MockDrinksRepository();

  group('Drinks Category Bloc', () {
    late DrinksCategoryBloc _bloc;

    setUp(() {
      _bloc = DrinksCategoryBloc(mockDrinksRepository);
    });

    test('Initial state is Loading', () {
      expect(_bloc.state, CategoryLoading());
    });

    var categoryList = [UiDrinksCategory(name: 'Cocktail', isSelected: true)];
    blocTest<DrinksCategoryBloc, CategoryState>(
        'When InitialLoad succeed, show Loading followed by Loaded',
        build: () {
          when(mockDrinksRepository.getAllCategories())
              .thenAnswer((_) async => Right(categoryList));
          return _bloc;
        },
        act: (bloc) => bloc.add(CategoryInitialLoad()),
        expect: () => <CategoryState>[
              CategoryLoading(),
              CategoryLoaded(categoryList)
            ]);

    var exception = Exception();
    blocTest<DrinksCategoryBloc, CategoryState>(
        'When InitialLoad failed, show Loading followed by Error',
        build: () {
          when(mockDrinksRepository.getAllCategories())
              .thenAnswer((_) async => Left(exception));
          return _bloc;
        },
        act: (bloc) => bloc.add(CategoryInitialLoad()),
        expect: () =>
            <CategoryState>[CategoryLoading(), CategoryError(exception)]);

    var unselectedItem = UiDrinksCategory(name: 'Cocktail', isSelected: false);
    var selectedItem = UiDrinksCategory(name: 'Cocktail', isSelected: true);
    blocTest<DrinksCategoryBloc, CategoryState>(
        'When an unselected item is clicked, emit DrinksCategorySelected event',
        build: () => _bloc,
        act: (bloc) => bloc.add(CategoryClicked(unselectedItem, [unselectedItem])),
        expect: () => <CategoryState>[
              CategorySelected([selectedItem])
            ]);

    blocTest<DrinksCategoryBloc, CategoryState>(
        'When a selected item is clicked, emit DrinksCategoryUnselected event',
        build: () => _bloc,
        act: (bloc) => bloc.add(CategoryClicked(selectedItem, [selectedItem])),
        expect: () => <CategoryState>[
              CategoryUnselected([unselectedItem])
            ]);
  });
}
