import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kascollection/states/site_settings_state.dart';
import 'package:kascollection/utils/auth_repository.dart';
import 'package:kascollection/utils/enums.dart';

class SiteSettingsCubit extends Cubit<SiteSettingsState> {
  AuthRepository authRepository;

 SiteSettingsCubit({required this.authRepository})
      : super(SiteSettingsState.initial());

  void login() async {
    emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loading));

    (bool,dynamic) response = await authRepository.userSiteSettings();

    if (response.$1 == true) {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.loaded,model: response.$2,));
    } else {
      emit(state.copyWith(networkStatusEnum: NetworkStatusEnum.failed,model: response.$2));
    }
  }
  
}