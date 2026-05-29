import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmin/features/home/cubit/cubit/home_state.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  UserData? userData;

  Future<void> getUserData() async {
    emit(GetUserDataLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(GetUserDataError("No user logged in"));
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      userData = UserData.fromJson(doc.data()!);

      emit(GetUserDataSuccess(userData!));
    } catch (e) {
      emit(GetUserDataError(e.toString()));
    }
  }

  void updateLocalName(String newName) {
    if (userData != null) {
      userData = userData!.copyWith(name: newName);
      emit(GetUserDataSuccess(userData!));
    }
  }
}
