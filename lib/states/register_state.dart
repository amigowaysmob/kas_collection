import 'package:equatable/equatable.dart';

import 'package:kascollection/response_model/register_model.dart';
import 'package:kascollection/utils/enums.dart';


class RegisterState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final RegisterModel model;



  const RegisterState({
    required this.networkStatusEnum,
    required this.model
  });

  factory RegisterState.initial() =>  RegisterState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: RegisterModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 RegisterState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     RegisterModel? model}) {
    return RegisterState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
