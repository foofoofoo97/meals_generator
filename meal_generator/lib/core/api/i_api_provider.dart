import 'package:meal_generator/core/network/i_network_client.dart';

abstract class IApiProvider<T1, T2> {
  final INetworkClient client;

  IApiProvider(this.client);
  
  Future<T1> getAllCategories();
  Future<T2> getAllChoicesByCategory(String category);
}
