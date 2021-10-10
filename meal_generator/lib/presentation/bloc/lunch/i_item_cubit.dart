import 'package:bloc/bloc.dart';
import 'package:meal_generator/core/repository/i_repository.dart';
import 'package:meal_generator/presentation/bloc/lunch/item_state.dart';
import 'package:meal_generator/core/extensions/list_extensions.dart';
import 'package:meal_generator/presentation/models/ui_category.dart';

abstract class IItemCubit<T extends UiCategory,T2> extends Cubit<ItemState> {
  late IRepository<T,T2> iRepo;
  late String category;

  IItemCubit(this.iRepo, this.category) : super(ItemLoading());

  void load() async {
    var allDrinks = await iRepo.getAllChoicesByCategory(category);
    allDrinks.fold((exception) => emit(ItemError(exception)), (list) {
      emit(ItemLoaded<T2>(list.random()));
    });
  }

  void reload() {
    emit(ItemLoading());
    load();
  }
}
