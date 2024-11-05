import 'package:equatable/equatable.dart';
import 'package:kascollection/response_model/site_settings_model.dart';
import 'package:kascollection/utils/enums.dart';


class SiteSettingsState extends Equatable {
  final NetworkStatusEnum networkStatusEnum;
  final SiteSettingsModel model;



  const SiteSettingsState({
    required this.networkStatusEnum,
    required this.model
  });

  factory SiteSettingsState.initial() =>  SiteSettingsState(
        networkStatusEnum: NetworkStatusEnum.initial,
       model: SiteSettingsModel(),
      );

  @override
  List<Object?> get props => [networkStatusEnum,model];

 SiteSettingsState copyWith(
      {NetworkStatusEnum? networkStatusEnum,
      NetworkStatusEnum? childNetworkStatusEnum,
      int? currentPage,
     SiteSettingsModel? model}) {
    return SiteSettingsState(
     model: model??this.model,
        networkStatusEnum: networkStatusEnum ?? this.networkStatusEnum);
        
  }
}
