import 'package:equatable/equatable.dart';

import 'package:kascollection/response_model/login_model.dart';
import 'package:kascollection/utils/enums.dart';

class LoginState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final LoginModel model;



  const LoginState({
    required this.networkStatusEnum,
    required this.model
  });

  factory LoginState.initial() =>  LoginState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: LoginModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 LoginState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     LoginModel? model}) {
    return LoginState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
