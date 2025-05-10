import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post/core/error/exception.dart';
import 'package:post/feature/post/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

// const BASE_URL ="https://jsonplaceholder.typicode.com";
 const BASE_URL ="https://mocki.io/v1/2a4fa496-157d-4b8f-96de-3563de4a09e2";
//const BASE_URL = "https://dummyjson.com/posts";
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      //  Uri.parse(BASE_URL+"/posts/"),
       Uri.parse(BASE_URL),
        headers: {"Content-Type": "application/json"});
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();


      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'caption': postModel.caption,
      'shares': postModel.shares,
      'comments': postModel.comments,
      'likes': postModel.likes,
      'timeAgo': postModel.timeAgo,
      'imageUrl': postModel.imageUrl,
    };
    final response =
        await client.post(Uri.parse("$BASE_URL/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse("$BASE_URL/POSTS/${postId.toString()}"),
        headers: {"Content_Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'caption': postModel.caption,
      'shares': postModel.shares,
      'comments': postModel.comments,
      'likes': postModel.likes,
      'timeAgo': postModel.timeAgo,
      'imageUrl': postModel.imageUrl,
    };
    final response =
        await client.patch(Uri.parse("$BASE_URL/posts/$postId"),body: body);
    if(response.statusCode==200){
      return Future.value(unit);
    }else{throw ServerException();}
  }
}
