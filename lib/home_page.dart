import 'package:flutter/material.dart';
import 'package:post/fake_data.dart';
import 'package:post/feature/post/presentation/ui/add_post_page.dart';
import 'package:post/feature/post/presentation/widgets/post_widget.dart';
import 'package:post/global_widget/app_avatar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddPostPage()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text(
            "Posts",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final post = FakeData.posts[index];
                  return PostWidget(
                    post: post,
                  );
                },
                childCount: FakeData.posts.length,
              ),
            ),
          ],
        ));
  }
}
