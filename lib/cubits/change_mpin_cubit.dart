import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kascollection/states/change_mpin_state.dart';
import 'package:kascollection/utils/auth_repository.dart';

class ChangeMpinCubit extends Cubit<ChangeMpinState> {
  AuthRepository authRepository;

 ChangeMpinCubit({required this.authRepository})
      : super(ChangeMpinState.initial());

  void login(ChangeMpinRequestModel changeMpinRequestModel) async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userChangeMpin(changeMpinRequestModel);

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}