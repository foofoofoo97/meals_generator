import 'package:equatable/equatable.dart';

abstract class UiCategory extends Equatable {
  bool isSelected;
  String name;

  UiCategory({required this.isSelected,required this.name});

  List<Object?> get props => [name, isSelected];
}
