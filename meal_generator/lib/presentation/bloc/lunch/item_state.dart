import 'package:equatable/equatable.dart';

class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemLoading extends ItemState {
}

class ItemLoaded<T> extends ItemState {
  final T item;

  ItemLoaded(this.item);

  @override
  List<Object?> get props => [item];
}

class ItemError extends ItemState {
  final Exception exception;

  ItemError(this.exception);

  @override
  List<Object?> get props => [exception];
}