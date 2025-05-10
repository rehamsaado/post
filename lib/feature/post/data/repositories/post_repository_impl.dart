import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:post/core/error/exception.dart';
import 'package:post/core/error/failures.dart';
import 'package:post/core/network/network_info.dart';
import 'package:post/feature/post/data/models/post_model.dart';
import 'package:post/feature/post/domain/entities/post.dart';
import 'package:post/feature/post/domain/repositories/posts_repository.dart';

import '../datasource/post_local_data_source.dart';
import '../datasource/post_remote_data_source.dart';
typedef Future<Unit> DeleteOrUpdateOrAddPost();
class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        // localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      caption: post.caption,
      timeAgo: post.timeAgo,
      likes: post.likes,
      comments: post.comments,
      shares: post.shares,
      user: post.user,
    );
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      caption: post.caption,
      timeAgo: post.timeAgo,
      likes: post.likes,
      comments: post.comments,
      shares: post.shares,
      user: post.user,
    );
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
