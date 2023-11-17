import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/contents/contents.dart';

class ContentsList extends StatefulWidget {
  const ContentsList({super.key});

  @override
  State<ContentsList> createState() => _PostsListState();
}

class _PostsListState extends State<ContentsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        switch (state.status) {
          case ContentStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case ContentStatus.success:
            if (state.contents.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.contents.length
                    ? const BottomLoader()
                    : ContentListItem(content: state.contents[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.contents.length
                  : state.contents.length + 1,
              controller: _scrollController,
            );
          case ContentStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
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
    if (_isBottom) context.read<ContentBloc>().add(ContentFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
