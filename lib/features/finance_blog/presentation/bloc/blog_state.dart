part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  const BlogFailure(this.error);
  @override
  List<Object> get props => [error];
}

final class BlogsDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  const BlogsDisplaySuccess(this.blogs);
   @override
  List<Object> get props => [blogs];
}

final class BlogSuccess extends BlogState{}