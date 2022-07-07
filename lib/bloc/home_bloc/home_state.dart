part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({
    required this.posts,
    required this.hasReachedMax,
  });

  final List<PhotoModel> posts;
  final bool hasReachedMax;
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(hasReachedMax: false, posts: const []);

  @override
  List<Object?> get props => [posts, hasReachedMax];
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState({
    required List<PhotoModel> posts,
    required bool hasReachedMax,
  }) : super(hasReachedMax: hasReachedMax, posts: posts);

  @override
  List<Object?> get props => [posts, hasReachedMax];
}

class HomeErrorState extends HomeState {
  const HomeErrorState({
    required List<PhotoModel> posts,
  }) : super(hasReachedMax: true, posts: posts);

  @override
  List<Object?> get props => [posts, hasReachedMax];
}
