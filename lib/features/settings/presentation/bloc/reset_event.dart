part of 'reset_bloc.dart';

sealed class ResetEvent extends Equatable {
  const ResetEvent();

  @override
  List<Object> get props => [];
}
class ResetAppData extends ResetEvent{}

