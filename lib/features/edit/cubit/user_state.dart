import 'package:meta/meta.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

@immutable
sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserData user;

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
