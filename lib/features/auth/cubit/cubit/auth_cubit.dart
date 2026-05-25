import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programmin/features/auth/data/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final response = await AuthRepo.login(email: email, password: password);

      if (response != null) {
        emit(AuthSuccessState(response.user!.uid));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoadingState());
    try {
      final response = await AuthRepo.signInWithGoogle();
      if (response != null) {
        emit(AuthSuccessState(response.user?.uid ?? ""));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());

    try {
      final response = await AuthRepo.register(
        name: name,
        email: email,
        password: password,
      );

      if (response != null) {
        emit(AuthSuccessState(response.user!.uid));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
