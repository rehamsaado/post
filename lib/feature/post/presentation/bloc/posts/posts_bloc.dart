import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:post/core/error/failures.dart';
import 'package:post/core/strings/failure.dart';
import 'package:post/feature/post/domain/entities/post.dart';
import 'package:post/feature/post/domain/usecase/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostEvent) {
        emit(LoadingPostState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostEvent) {
        emit(LoadingPostState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostState(message: _mapFailureToMessage(failure)),
        (posts) => LoadedPostState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "unExpected Error please try again later";
    }
  }
}
