import 'package:equatable/equatable.dart';


class ChangeMpinState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final ChangeMpinModel model;



  const ChangeMpinState({
    required this.networkStatusEnum,
    required this.model
  });

  factory ChangeMpinState.initial() =>  ChangeMpinState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: ChangeMpinModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 ChangeMpinState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     ChangeMpinModel? model}) {
    return ChangeMpinState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
