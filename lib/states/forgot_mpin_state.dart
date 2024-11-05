import 'package:equatable/equatable.dart';
import 'package:kascollection/response_model/forgot_mpin_model.dart';


import 'package:kascollection/utils/enums.dart';

class ForgotMpinState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final ForgotMpinModel model;



  const ForgotMpinState({
    required this.networkStatusEnum,
    required this.model
  });

  factory ForgotMpinState.initial() =>  ForgotMpinState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: ForgotMpinModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 ForgotMpinState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     ForgotMpinModel? model}) {
    return ForgotMpinState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
