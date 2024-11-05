import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kascollection/states/reset_mpin_state.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/enums.dart';

class ResetMpinCubit extends Cubit<ResetMpinState> {
  AuthRepository authRepository;

 ResetMpinCubit({required this.authRepository})
      : super(ResetMpinState.initial());

  void login(RegisterMpinRequestModel resetMpinRequestModel) async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userResetMpin(resetMpinRequestModel);

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}