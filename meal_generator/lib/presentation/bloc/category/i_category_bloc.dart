import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meal_generator/core/repository/i_repository.dart';
import 'package:meal_generator/presentation/bloc/category/category_event.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/models/ui_category.dart';

abstract class ICategoryBloc<T extends UiCategory,T2> extends Bloc<CategoryEvent, CategoryState> {
  late IRepository<T,T2> drinksRepo;

  ICategoryBloc(this.drinksRepo) : super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryInitialLoad) {
      yield CategoryLoading();
      yield await _proceedToLoad();
    } else if (event is CategoryReload) {
      yield CategoryLoading();
      yield await _proceedToLoad();
    } else if (event is CategoryClicked<T>) {
      yield itemClicked(event.category, event.categoryList);
    }
  }

  Future<CategoryState> _proceedToLoad() async {
    Either<Exception, List<T>> result = await drinksRepo.getAllCategories();

    return result.fold((exception) => CategoryError(exception), (categories) {
      return CategoryLoaded(categories);
    });
  }

  @protected
  CategoryState itemClicked(T clickedItem, List<T> oldList);
}
