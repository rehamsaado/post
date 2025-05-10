import 'package:post/feature/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.caption,
    required super.timeAgo,
    required super.likes,
    required super.comments,
    required super.shares,
    required super.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json){
    return PostModel(
       id: json['id'],
      caption: json['caption'],
      timeAgo: json['timeAgo'],
      likes: json['likes'],
      comments: json['comments'],
      shares: json['shares'],
      user: json['user'],);
  }

  Map<String,dynamic> toJson(){
    return {
       'id':id,
      'caption':caption,
      'timeAgo':timeAgo,
      'likes':likes,
      'comments':comments,
      'shares':shares,
      'user':user,
    };
}
}

