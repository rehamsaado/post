part of 'add_delete_update_post_bloc.dart';

@immutable
sealed class AddDeleteUpdatePostEvent {}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int  postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
