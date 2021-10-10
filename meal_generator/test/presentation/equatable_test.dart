import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Equality for Error state: True', () {
    var exception = Exception();
    var first = CategoryError(exception);
    var second = CategoryError(exception);
    assert(first == second);
  });

  test('Equality for Error state: False', () {
    var first = CategoryError(Exception());
    var second = CategoryError(Exception());
    assert(first != second);
  });

  test('Equality for Loading state: always True', () {
    var first = CategoryLoading();
    var second = CategoryLoading();
    assert(first == second);
  });
}
