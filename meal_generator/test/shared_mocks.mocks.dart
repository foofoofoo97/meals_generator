// Mocks generated by Mockito 5.0.15 from annotations
// in meal_generator/test/shared_mocks.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:meal_generator/core/api/drinks/models/drinks_list.dart' as _i5;
import 'package:meal_generator/core/api/meals/models/meals_list.dart' as _i8;
import 'package:meal_generator/core/repository/drinks/drinks_repository.dart'
    as _i3;
import 'package:meal_generator/core/repository/meals/meals_repository.dart'
    as _i6;
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';
import 'package:meal_generator/presentation/models/ui_meals_category.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [DrinksRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDrinksRepository extends _i1.Mock implements _i3.DrinksRepository {
  MockDrinksRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<Exception, List<UiDrinksCategory>>> getAllCategories() =>
      (super.noSuchMethod(Invocation.method(#getAllCategories, []),
              returnValue: Future<_i2.Either<Exception, List<UiDrinksCategory>>>.value(
                  _FakeEither_0<Exception, List<UiDrinksCategory>>()))
          as _i4.Future<_i2.Either<Exception, List<UiDrinksCategory>>>);
  @override
  _i4.Future<_i2.Either<Exception, List<_i5.Drinks>>> getAllChoicesByCategory(
          String? categoryName) =>
      (super.noSuchMethod(
          Invocation.method(#getAllChoicesByCategory, [categoryName]),
          returnValue: Future<_i2.Either<Exception, List<_i5.Drinks>>>.value(
              _FakeEither_0<Exception, List<_i5.Drinks>>())) as _i4
          .Future<_i2.Either<Exception, List<_i5.Drinks>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MealsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMealsRepository extends _i1.Mock implements _i6.MealsRepository {
  MockMealsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<Exception, List<_i7.UiMealsCategory>>>
      getAllCategories() => (super.noSuchMethod(
          Invocation.method(#getAllCategories, []),
          returnValue:
              Future<_i2.Either<Exception, List<_i7.UiMealsCategory>>>.value(
                  _FakeEither_0<Exception, List<_i7.UiMealsCategory>>())) as _i4
          .Future<_i2.Either<Exception, List<_i7.UiMealsCategory>>>);
  @override
  _i4.Future<_i2.Either<Exception, List<_i8.Meals>>> getAllChoicesByCategory(
          String? categoryName) =>
      (super.noSuchMethod(
              Invocation.method(#getAllChoicesByCategory, [categoryName]),
              returnValue: Future<_i2.Either<Exception, List<_i8.Meals>>>.value(
                  _FakeEither_0<Exception, List<_i8.Meals>>()))
          as _i4.Future<_i2.Either<Exception, List<_i8.Meals>>>);
  @override
  String toString() => super.toString();
}