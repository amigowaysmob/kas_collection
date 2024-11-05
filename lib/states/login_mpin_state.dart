import 'package:equatable/equatable.dart';

import 'package:kascollection/response_model/login_mpin_model.dart';
import 'package:kascollection/utils/enums.dart';

class LoginMpinState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final LoginMpinModel model;



  const LoginMpinState({
    required this.networkStatusEnum,
    required this.model
  });

  factory LoginMpinState.initial() =>  LoginMpinState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: LoginMpinModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 LoginMpinState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     LoginMpinModel? model}) {
    return LoginMpinState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
