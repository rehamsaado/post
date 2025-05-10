import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/fake_data.dart';
import 'package:post/feature/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:post/feature/post/presentation/ui/add_post_page.dart';

import 'feature/post/domain/entities/post.dart';
import 'feature/post/presentation/widgets/post_widget.dart';

class HomePage extends StatelessWidget {
  final List<Post> posts;

  const HomePage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddPostPage()));
        },
        child: const Icon(Icons.add),
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
      body: Padding(
          padding: EdgeInsets.all(10),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is LoadingPostState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedPostState) {
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          // final post = FakeData.posts[index];

                          return PostWidget(
                            post: posts[index],
                            // post: posts[index].id.toString(),
                          );
                        },
                        // childCount: FakeData.posts.length,
                        childCount: posts.length,
                      ),
                    ),
                  ],
                );
              } else if (state is ErrorPostState) {
                return Container(
                  child: Text(state.message),
                );
              }
              return Container();
            },
          )),
    );
  }
}
