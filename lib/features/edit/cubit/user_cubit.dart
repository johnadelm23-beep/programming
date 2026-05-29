import 'package:bloc/bloc.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';
import 'package:programmin/features/edit/data/user_repo.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  UserData? user;

  Future<void> loadUser() async {
    emit(UserLoading());

    try {
      final data = await UserRepo.getUserData();

      if (data != null) {
        user = data;
        emit(UserLoaded(data));
      } else {
        emit(UserError("User not found"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> updateName(String name) async {
    emit(UserLoading());

    try {
      await UserRepo.updateUserName(name);

      final updatedUser = await UserRepo.getUserData();

      if (updatedUser != null) {
        user = updatedUser;
        emit(UserLoaded(updatedUser));
      } else {
        emit(UserError("Failed to update user"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  /// 🔄 Refresh user (silent reload)
  Future<void> refreshUser() async {
    try {
      final data = await UserRepo.getUserData();

      if (data != null) {
        user = data;
        emit(UserLoaded(data));
      }
    } catch (_) {}
  }
}
