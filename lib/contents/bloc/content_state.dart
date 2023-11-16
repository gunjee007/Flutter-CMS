part of 'content_bloc.dart';

enum ContentStatus { initial, success, failure }

final class ContentState extends Equatable {
  const ContentState({
    this.status = ContentStatus.initial,
    this.contents = const <Content>[],
    this.hasReachedMax = false,
  });

  final ContentStatus status;
  final List<Content> contents;
  final bool hasReachedMax;

  ContentState copyWith({
    ContentStatus? status,
    List<Content>? contents,
    bool? hasReachedMax,
  }) {
    return ContentState(
      status: status ?? this.status,
      contents: contents ?? this.contents,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ContentState { status: $status, hasReachedMax: $hasReachedMax, contents: ${contents.length} }''';
  }

  @override
  List<Object> get props => [status, contents, hasReachedMax];
}
