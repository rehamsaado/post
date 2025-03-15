import 'package:flutter/material.dart';
import 'package:post/global_widget/app_avatar_widget.dart';
import 'package:post/global_widget/app_circle_button_widget.dart';
import 'package:post/global_widget/app_icon_widget.dart';
import 'package:post/global_widget/app_image_widget.dart';

import '../../../../global_widget/app_text_widget.dart';
import '../../domain/entities/post.dart';

class PostWidget extends StatelessWidget {
  final Post? post;

  const PostWidget({super.key, this.post});

  @override
  Widget build(BuildContext context) {
    final String userName = post?.user.name ??"user name";
    final String timeAgo = post?.timeAgo ?? "now";
    final String caption = post?.caption ?? "";
    final String imageUrl = post?.user.imageUrl ?? "assets/images/image_doctor.png";
    return Card(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppAvatarWidget(
               imageUrl: "assets/images/image_doctor.png",
             // imageUrl: imageUrl,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text:userName,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  Row(
                    children: [
                      AppTextWidget(
                        text: "$timeAgo • ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      AppIconWidget(
                        icon: Icons.public,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppCircleButtonWidget(
              iconData: Icons.more_horiz,
              onPressed: () {},
              iconSize: 30,
            ),

          ],
        ),
       AppTextWidget(text: caption),
       // Image.asset("assets/images/image_doctor.png"),
        AppImageWidget(path:"assets/images/image_doctor.png",height: 200,)
      ],
    ));
  }
}
