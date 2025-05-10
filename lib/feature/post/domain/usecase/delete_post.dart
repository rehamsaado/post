import 'package:dartz/dartz.dart';
import 'package:post/feature/post/domain/repositories/posts_repository.dart';

import '../../../../core/error/failures.dart';

class DeletePostUseCase{
  final PostsRepository repository;

  DeletePostUseCase(this.repository);
  Future<Either<Failure,Unit>> call(int postId)async{
    return  await repository.deletePost(postId);
  }
}