import 'package:finance_tracker/core/common/widgets/loader.dart';
import 'package:finance_tracker/core/theme/app_pallete.dart';
import 'package:finance_tracker/core/utils/show_snackbar.dart';
import 'package:finance_tracker/features/finance/presentation/pages/dashboardpage.dart';
import 'package:finance_tracker/features/finance_blog/presentation/bloc/blog_bloc.dart';
import 'package:finance_tracker/features/finance_blog/presentation/pages/add_new_blog.dart';
import 'package:finance_tracker/features/finance_blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Blogs'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, DashboardPage.route());
          },
          icon: const Icon(CupertinoIcons.home),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsDisplaySuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
