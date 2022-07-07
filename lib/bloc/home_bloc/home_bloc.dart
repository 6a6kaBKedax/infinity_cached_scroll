import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinity_cached_scroll/data/models/photo_model.dart';
import 'package:infinity_cached_scroll/res/consts/namespace_consts.dart';
import 'package:infinity_cached_scroll/services/repository/repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeRequestEvent>(_onRequest);
    on<HomeInitEvent>(_init);
  }

  static const int _postLimit = 20;

  Future<void> _onRequest(HomeRequestEvent event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      final List<PhotoModel> posts = await Repository.client.getPhotos(state.posts.length, _postLimit);
      if (posts.isEmpty || state.posts.length > 100) {
        HomeSuccessState(hasReachedMax: true, posts: state.posts);
      } else {
        HomeSuccessState(posts: List.of(state.posts)..addAll(posts), hasReachedMax: false);
      }
    } catch (e) {
      logger.e(e);
      emit(HomeErrorState(posts: state.posts));
    }
  }

  Future<void> _init(HomeInitEvent event, Emitter<HomeState> emit) async {
    try {
      final posts = await Repository.client.getPhotos(state.posts.length, _postLimit);
      return emit(HomeSuccessState(hasReachedMax: true, posts: posts));
    } on Exception catch (e) {
      logger.e(e);
      emit(HomeErrorState(posts: state.posts));
    }
  }
}
