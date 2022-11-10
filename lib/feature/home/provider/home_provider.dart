import 'package:flutter_boilerplate/feature/home/state/home_state.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider(ref);
});

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this._ref) : super(const HomeState.loading());
  final Ref _ref;
}
