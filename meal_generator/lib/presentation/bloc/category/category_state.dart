import 'package:equatable/equatable.dart';
import 'package:meal_generator/presentation/models/ui_category.dart';

class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded<T extends UiCategory> extends CategoryState {
  final List<T> items;

  CategoryLoaded(this.items);

  @override
  List<Object?> get props => items;
}

class CategoryError extends CategoryState {
  final Exception exception;

  CategoryError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class CategorySelected<T extends UiCategory> extends CategoryState {
  final List<T> items;

  CategorySelected(this.items);

  T? getSelectedCategory() {
    try {
      return items.firstWhere((it) => it.isSelected);
    } on StateError {
      return null;
    }
  }

  @override
  List<Object?> get props => items;
}

class CategoryUnselected<T extends UiCategory> extends CategoryState {
  final List<T> items;

  CategoryUnselected(this.items);

  @override
  List<Object?> get props => items;
}