import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kascollection/states/login_state.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/enums.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository authRepository;

 LoginCubit({required this.authRepository})
      : super(LoginState.initial());

  void login(LoginRequestModel loginRequestModel) async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userLogin(loginRequestModel);

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}
