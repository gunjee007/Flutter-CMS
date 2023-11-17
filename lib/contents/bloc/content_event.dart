part of 'content_bloc.dart';

sealed class ContentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ContentFetched extends ContentEvent {}
