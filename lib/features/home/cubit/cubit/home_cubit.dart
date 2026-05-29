import 'package:bloc/bloc.dart';
import 'package:programmin/features/auth/data/auth_repo.dart';
import 'package:programmin/features/home/cubit/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getUserData() async {
    emit(GetUserDataLoading());

    try {
      final user = await AuthRepo.getUserData();

      if (user == null) {
        emit(GetUserDataError("User not found"));
      } else {
        emit(GetUserDataSuccess(user));
      }
    } catch (e) {
      emit(GetUserDataError(e.toString()));
    }
  }
}
