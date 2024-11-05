import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kascollection/states/forgot_mpin_state.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/enums.dart';

class ForgotMpinCubit extends Cubit<ForgotMpinState> {
  AuthRepository authRepository;

 ForgotMpinCubit({required this.authRepository})
      : super(ForgotMpinState.initial());

  void login(UserIdRequestModel UserIdRequestModel) async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userForgotMpin(UserIdRequestModel);

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}