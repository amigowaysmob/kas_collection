import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kascollection/states/login_mpin_state.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/enums.dart';


class LoginMpinCubit extends Cubit<LoginMpinState> {
  AuthRepository authRepository;

 LoginMpinCubit({required this.authRepository})
      : super(LoginMpinState.initial());

  void login(LoginMpinRequestModel loginMpinRequestModel) async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userLoginMpin(loginMpinRequestModel);

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}