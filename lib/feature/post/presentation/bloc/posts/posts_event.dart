part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}



class GetAllPostEvent extends PostsEvent{}



class RefreshPostEvent extends PostsEvent{}