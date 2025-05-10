import 'package:equatable/equatable.dart';

import '../../../user/domain/user.dart';

class Post extends Equatable {
   final int id;
  final String caption;
  final String timeAgo;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;

  final User user;

  Post(
      {
      required this.id,
      required this.caption,
      required this.timeAgo,
      this.imageUrl,
      required this.likes,
      required this.comments,
      required this.shares,
      required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [
        caption,
        timeAgo,
        imageUrl,
        likes,
        comments,
        shares,
        // id,
      ];
}
