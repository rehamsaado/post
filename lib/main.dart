import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/core/app_theme.dart';
import 'package:post/feature/post/presentation/bloc/add_delete_bloc/add_delete_update_post_bloc.dart';
import 'package:post/feature/post/presentation/bloc/posts/posts_bloc.dart';
import 'home_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostEvent()),
          ),
          BlocProvider(
            create: (_) => di.sl<AddDeleteUpdatePostBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: appTheme,
          home: const HomePage(
            posts: [],
          ),
        ));
  }
}
