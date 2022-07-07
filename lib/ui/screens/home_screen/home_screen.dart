import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_cached_scroll/bloc/home_bloc/home_bloc.dart';
import 'package:infinity_cached_scroll/ui/screens/home_screen/widgets/bottom_loader.dart';
import 'package:infinity_cached_scroll/ui/screens/home_screen/widgets/item_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid on 100 elements 🧐'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeErrorState:
              return const Center(
                child: Text('failed to fetch posts'),
              );
            case HomeSuccessState:
              if (state.posts.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return GridView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (!state.hasReachedMax && index == state.posts.length) {
                    return const BottomLoader(endOfStory: false);
                  } else if (state.hasReachedMax && index == state.posts.length) {
                    return const SizedBox();
                  } else if (state.hasReachedMax && index >= state.posts.length) {
                    return const BottomLoader(endOfStory: true);
                  } else {
                    return ItemTile(
                      index: index,
                      url: state.posts[index].url,
                    );
                  }
                },
                itemCount: state.hasReachedMax ? state.posts.length + 2 : state.posts.length + 1,
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              );
            default:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeBloc>().add(const HomeRequestEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
