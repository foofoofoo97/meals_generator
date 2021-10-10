import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_generator/core/api/meals/models/meals_list.dart';
import 'package:meal_generator/presentation/bloc/lunch/item_state.dart';
import 'package:meal_generator/presentation/bloc/lunch/meals/meals_cubit.dart';
import 'package:mockito/mockito.dart';
import '../../shared_mocks.mocks.dart';

void main() {
  var mockMealsRepository = MockMealsRepository();

  group('Meals Cubit', () {
    late MealsCubit _cubit;
    final String _categoryName = 'Side Dish';
    final Meals _meals = Meals('1', 'French Fries', 'frenchFries.jpg');

    setUp(() {
      _cubit = MealsCubit(mockMealsRepository, _categoryName);
    });

    test('Initial state is Loading', () {
      expect(_cubit.state, ItemLoading());
    });

    blocTest<MealsCubit, ItemState>('When network call succeed, show Loaded state',
        build: () {
          when(mockMealsRepository.getAllChoicesByCategory(_categoryName))
              .thenAnswer((_) async => Right([_meals]));
          return _cubit;
        },
        act: (cubit) => cubit.load(),
        expect: () => <ItemState>[ItemLoaded(_meals)]);

    var exception = Exception();
    blocTest<MealsCubit, ItemState>('When network call failed, show Error state',
        build: () {
          when(mockMealsRepository.getAllChoicesByCategory(_categoryName))
              .thenAnswer((_) async => Left(exception));
          return _cubit;
        },
        act: (cubit) => cubit.load(),
        expect: () => <ItemState>[ItemError(exception)]);
  });

}
