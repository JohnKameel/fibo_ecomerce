import 'package:bloc/bloc.dart';
import 'package:fido_e/features/auth/data/repo/auth_repo.dart';
import 'package:fido_e/features/auth/data/repo/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  AuthRepository _auth;
  RegisterCubit(this._auth) : super(RegisterInitial());



  register(String username, String email, String password) async {
    emit(RegisterLoading());

    try{
      final result = await _auth.registerByApi(username, email, password);
      result.fold(
        (failure) => emit(RegisterFailure(failure.message)),
        (user) => emit(RegisterSuccess(user)),
      );
    } catch(e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
