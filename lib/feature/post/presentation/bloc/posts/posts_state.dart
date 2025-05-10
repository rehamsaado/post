part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class LoadingPostState extends PostsState {}

class LoadedPostState extends PostsState {
  final List<Post> posts;

  LoadedPostState({required this.posts});

  @override
  List<Object> get props => [posts];
}



class ErrorPostState extends PostsState{
  final String message;

  ErrorPostState({required this.message});

  @override
  List<Object> get props => [message];
}