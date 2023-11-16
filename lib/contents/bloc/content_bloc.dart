import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cms/contents/contents.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'content_event.dart';
part 'content_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc({required this.httpClient}) : super(const ContentState()) {
    on<ContentFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
    ContentFetched event,
    Emitter<ContentState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ContentStatus.initial) {
        final contents = await _fetchContents();
        return emit(
          state.copyWith(
            status: ContentStatus.success,
            contents: contents,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await _fetchContents(state.contents.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ContentStatus.success,
                contents: List.of(state.contents)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ContentStatus.failure));
    }
  }

  Future<List<Content>> _fetchContents([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'dummyjson.com',
        '/products',
        <String, String>{'skip': '$startIndex', 'limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      try {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final products = body['products'] as List;
        return products.map((dynamic json) {
          return Content.fromJson(json as Map<String, dynamic>);
        }).toList();
      } catch (e) {
        throw Exception('error fetching posts');
      }
    }
    throw Exception('error fetching posts');
  }
}
