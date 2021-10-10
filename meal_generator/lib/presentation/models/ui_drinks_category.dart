import 'package:meal_generator/presentation/models/ui_category.dart';

class UiDrinksCategory extends UiCategory {
  String name;
  bool isSelected;

  UiDrinksCategory({required this.name, required this.isSelected}):super(name:name,isSelected: isSelected);
}
