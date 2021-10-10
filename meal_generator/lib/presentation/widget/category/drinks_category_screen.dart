import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_generator/presentation/bloc/category/category_event.dart';
import 'package:meal_generator/presentation/bloc/category/category_state.dart';
import 'package:meal_generator/presentation/bloc/category/drinks/drinks_category_bloc.dart';
import 'package:meal_generator/presentation/models/ui_drinks_category.dart';
import 'package:meal_generator/presentation/widget/list_error_indicator.dart';

import '../list_loading_indicator.dart';

class DrinksCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrinksCategoryScreenState();
}

class DrinksCategoryScreenState extends State<DrinksCategoryScreen> {
  late DrinksCategoryBloc _drinksBloc;

  @override
  void initState() {
    super.initState();
    _drinksBloc = BlocProvider.of<DrinksCategoryBloc>(context);
    _drinksBloc.add(CategoryInitialLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrinksCategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return ListLoadingIndicator();
      } else if (state is CategoryLoaded<UiDrinksCategory>) {
        return _buildList(state.items);
      } else if (state is CategorySelected<UiDrinksCategory>) {
        return _buildList(state.items);
      } else if (state is CategoryUnselected<UiDrinksCategory>) {
        return _buildList(state.items);
      } else if (state is CategoryError) {
        return ListErrorIndicator(_reloadList);
      } else {
        throw Error();
      }
    });
  }

  void _reloadList() {
    _drinksBloc.add(CategoryReload());
  }

  Widget _buildList(List<UiDrinksCategory> categoryList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, i) {
        var category = categoryList[i];
        return Container(
          margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
          child: Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.local_drink_rounded,
                  color: category.isSelected ? Colors.blue : Colors.grey),
              title: Text(category.name),
              onTap: () {
                _drinksBloc.add(CategoryClicked(category, categoryList));
              },
            ),
          ),
        );
      }, childCount: categoryList.length),
    );
  }
}
