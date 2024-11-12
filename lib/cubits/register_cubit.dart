import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kascollection/states/register_state.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/enums.dart';



class RegisterCubit extends Cubit<RegisterState> {
  AuthRepository authRepository;

 RegisterCubit({required this.authRepository})
      : super(RegisterState.initial());

  void login(RegisterRequestModel registerRequestModel) async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userRegister(registerRequestModel);

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}