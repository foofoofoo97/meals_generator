import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:meal_generator/core/api/drinks/models/drinks_list.dart';
import 'package:meal_generator/presentation/bloc/lunch/drinks/drinks_cubit.dart';
import 'package:meal_generator/presentation/bloc/lunch/item_state.dart';
import 'package:mockito/mockito.dart';
import '../../shared_mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var mockDrinksRepository = MockDrinksRepository();

  group('Drinks Cubit', () {
    late DrinksCubit _cubit;
    final String _categoryName = 'Cocktail';
    final Drinks _drinks = Drinks('1', 'Grape Juice', 'grapejuice.jpg');

    setUp(() {
      _cubit = DrinksCubit(mockDrinksRepository, _categoryName);
    });

    test('Initial state is Loading', () {
      expect(_cubit.state, ItemLoading());
    });

    blocTest<DrinksCubit, ItemState>('When network call succeed, show Loaded state',
        build: () {
          when(mockDrinksRepository.getAllChoicesByCategory(_categoryName))
              .thenAnswer((_) async => Right([_drinks]));
          return _cubit;
        },
        act: (cubit) => cubit.load(),
        expect: () => <ItemState>[ItemLoaded(_drinks)]);

    var exception = Exception();
    blocTest<DrinksCubit, ItemState>('When network call failed, show Error state',
        build: () {
          when(mockDrinksRepository.getAllChoicesByCategory(_categoryName))
              .thenAnswer((_) async => Left(exception));
          return _cubit;
        },
        act: (cubit) => cubit.load(),
        expect: () => <ItemState>[ItemError(exception)]);
  });
}
