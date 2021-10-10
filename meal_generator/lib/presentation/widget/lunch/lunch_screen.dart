import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_generator/core/api/drinks/models/drinks_list.dart';
import 'package:meal_generator/core/api/meals/models/meals_list.dart';
import 'package:meal_generator/presentation/bloc/lunch/drinks/drinks_cubit.dart';
import 'package:meal_generator/presentation/bloc/lunch/i_item_cubit.dart';
import 'package:meal_generator/presentation/bloc/lunch/item_state.dart';
import 'package:meal_generator/presentation/bloc/lunch/meals/meals_cubit.dart';
import 'package:meal_generator/presentation/widget/lunch/lunch_item.dart';

class LunchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  late MealsCubit mealsCubit;
  late DrinksCubit drinksCubit;

  @override
  void initState() {
    super.initState();
    mealsCubit = BlocProvider.of(context)..load();
    drinksCubit = BlocProvider.of(context)..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lunch of the day'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Flexible(child: _buildItem<MealsCubit,Meals>()), Flexible(child: _buildItem<DrinksCubit,Drinks>())],
            ),
            _buildRefreshLabel()
          ],
        ));
  }

  Widget _buildItem<T extends IItemCubit,T2>() {
    return BlocBuilder<T, ItemState>(
      builder: (context, state) {
        if (state is ItemLoading) {
          return _buildLoadingIndicator();
        } else if (state is ItemLoaded) {
          var meals = state.item;
          return LunchItem(name: meals.name, imageUrl: meals.thumbnailUrl);
        } else if (state is ItemError) {
          return Text('Error');
        } else {
          throw UnimplementedError();
        }
      },
    );
  }


  Widget _buildLoadingIndicator() {
    return Container(
      height: 250,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildRefreshLabel() {
    return InkWell(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(style: Theme.of(context).textTheme.bodyText2, children: [
              WidgetSpan(
                  child: Icon(Icons.star, color: Colors.red),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(text: 'Press here to get another meal set suggestion')
            ]),
          )),
      onTap: () {
        mealsCubit.reload();
        drinksCubit.reload();
      },
    );
  }
}
