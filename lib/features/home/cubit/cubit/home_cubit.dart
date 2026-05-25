import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programmin/features/auth/data/auth_repo.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  UserData? userData;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    final user = await AuthRepo.getUserData();
    if (user != null) {
      userData = user;
      emit(GetUserDataSuccess());
    } else {
      emit(GetUserDataError());
    }
  }
}
