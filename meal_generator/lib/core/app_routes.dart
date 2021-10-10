import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_generator/core/repository/drinks/drinks_repository.dart';
import 'package:meal_generator/core/repository/meals/meals_repository.dart';
import 'package:meal_generator/presentation/bloc/lunch/drinks/drinks_cubit.dart';
import 'package:meal_generator/presentation/bloc/lunch/meals/meals_cubit.dart';
import 'package:meal_generator/presentation/widget/lunch/lunch_screen.dart';
import 'app_path.dart' as app_path;
import 'di/service_locator.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings, BuildContext context) {
    switch (routeSettings.name) {
      case app_path.lunch:
        var tuple = routeSettings.arguments as Tuple2<String, String>;
        var mealsCategoryName = tuple.value1;
        var drinksCategoryName = tuple.value2;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) =>
                    MealsCubit(sl.get<MealsRepository>(), mealsCategoryName)),
            BlocProvider(
                create: (context) =>
                    DrinksCubit(sl.get<DrinksRepository>(), drinksCategoryName))
          ], child: LunchScreen()),
        );

      default:
        return MaterialPageRoute<Scaffold>(builder: (context) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${routeSettings.name}')),
          );
        });
    }
  }
}
