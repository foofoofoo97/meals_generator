import 'package:meal_generator/presentation/models/ui_category.dart';

class UiMealsCategory extends UiCategory {
  String id;
  String name;
  String thumbnailUrl;
  String description;
  bool isSelected;

  UiMealsCategory(
      {required this.id,
      required this.name,
      required this.thumbnailUrl,
      required this.description,
      required this.isSelected}):
      super(name: name,isSelected: isSelected);

}
