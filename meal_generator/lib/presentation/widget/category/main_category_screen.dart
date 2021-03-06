import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_generator/presentation/bloc/category/category_event.dart';
import 'package:meal_generator/presentation/bloc/category/drinks/drinks_category_bloc.dart';
import 'package:meal_generator/presentation/bloc/category/main/main_category_cubit.dart';
import 'package:meal_generator/presentation/bloc/category/meals/meals_category_bloc.dart';
import 'package:meal_generator/presentation/widget/category/drinks_category_screen.dart';
import 'package:meal_generator/presentation/widget/category/meals_category_screen.dart';
import 'package:meal_generator/core/app_path.dart' as app_path;

class MainCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> with AutomaticKeepAliveClientMixin {
  late MainCategoryCubit _mainCategoryBloc;
  late MealsCategoryBloc _mealsCategoryBloc;
  late DrinksCategoryBloc _drinksCategoryBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _mainCategoryBloc = BlocProvider.of<MainCategoryCubit>(context);
    _mealsCategoryBloc = BlocProvider.of(context);
    _drinksCategoryBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refreshList,
          child: CustomScrollView(
            shrinkWrap: true, // if set to false, exception will be thrown wh?y?
            slivers: [
              _buildHeader(),
              MealsCategoryScreen(),
              DrinksCategoryScreen(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.00),
          child: Align(alignment: Alignment.bottomRight, child: _buildFloatingActionButton()),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Please select one meal & one drink',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return StreamBuilder(
      stream: _mainCategoryBloc.userHasChosenMealsAndDrinks(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        var isEnabled = snapshot.data ?? false;
        return FloatingActionButton(
            onPressed: isEnabled ? () => _displayLunchScreen(context) : null,
            backgroundColor: isEnabled ? Colors.blueAccent : Colors.grey,
            // null means use inherited theme color
            child: Icon(
              Icons.shopping_cart,
            ));
      },
    );
  }

  void _displayLunchScreen(BuildContext context) {
    var mealsCategory = _mainCategoryBloc.getSelectedMealCategory();
    var drinksCategory = _mainCategoryBloc.getSelectedDrinksCategory();
    if (mealsCategory == null || drinksCategory == null) {
      return;
    }
    Navigator.pushNamed(context, app_path.lunch,
        arguments: Tuple2(mealsCategory.name, drinksCategory.name));
  }

  Future<void> _refreshList() async {
    _mealsCategoryBloc.add(CategoryInitialLoad());
    _drinksCategoryBloc.add(CategoryInitialLoad());
  }
}
