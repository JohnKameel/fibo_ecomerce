import 'package:bloc/bloc.dart';
import 'package:fido_e/features/auth/data/repo/auth_repository.dart';
import 'package:meta/meta.dart';
import '../../data/model/user_model.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository _auth ;
  LoginCubit(this._auth) : super(LoginInitial());


  // controller here
  login(String username, String password) async {
    emit(LoginLoading());

    try{
      final result = await _auth.loginByApi(username, password);
      result.fold((failure) => emit(LoginFailure(failure.message)),
        (user) => emit(LoginSuccess(user)));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}


// dispose controller here if i add it