import 'package:equatable/equatable.dart';
import 'package:meal_generator/core/api/drinks/models/drinks_category_list.dart';
import 'package:meal_generator/presentation/models/ui_category.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';

class CategoryEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CategoryInitialLoad extends CategoryEvent {}

class CategoryReload extends CategoryEvent {}

class CategoryClicked<T extends UiCategory> extends CategoryEvent {
  final T category;
  final List<T> categoryList;

  CategoryClicked(this.category, this.categoryList);

  @override
  List<Object> get props => [category];
}