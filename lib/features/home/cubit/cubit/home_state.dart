import 'package:meta/meta.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserDataLoading extends HomeState {}

class GetUserDataSuccess extends HomeState {
  final UserData user;

  GetUserDataSuccess(this.user);
}

class GetUserDataError extends HomeState {
  final String error;

  GetUserDataError(this.error);
}
