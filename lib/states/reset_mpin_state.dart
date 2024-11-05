import 'package:equatable/equatable.dart';
import 'package:kascollection/utils/enums.dart';


class ResetMpinState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final ResetMpinModel model;



  const ResetMpinState({
    required this.networkStatusEnum,
    required this.model
  });

  factory ResetMpinState.initial() =>  ResetMpinState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: ResetMpinModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 ResetMpinState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     ResetMpinModel? model}) {
    return ResetMpinState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
