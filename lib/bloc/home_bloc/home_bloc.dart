import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinity_cached_scroll/data/models/photo_model.dart';
import 'package:infinity_cached_scroll/res/consts/namespace_consts.dart';
import 'package:infinity_cached_scroll/services/repository/repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeRequestEvent>(_onRequest, transformer: throttleDroppable());
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
        HomeSuccessState(posts: [...state.posts, ...posts], hasReachedMax: false);
      }
    } catch (e) {
      logger.e(e);
      emit(HomeErrorState(posts: state.posts));
    }
  }

  Future<void> _init(HomeInitEvent event, Emitter<HomeState> emit) async {
    try {
      final posts = await Repository.client.getPhotos(state.posts.length, _postLimit);
      return emit(HomeSuccessState(hasReachedMax: false, posts: posts));
    } on Exception catch (e) {
      logger.e(e);
      emit(HomeErrorState(posts: state.posts));
    }
  }

  EventTransformer<E> throttleDroppable<E>() {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(const Duration(milliseconds: 100)), mapper);
    };
  }
}
