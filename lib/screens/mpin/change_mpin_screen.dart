import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kascollection/cubits/change_mpin_cubit.dart';
import 'package:kascollection/states/change_mpin_state.dart';
import 'package:kascollection/utils/constant.dart';
import 'package:kascollection/utils/constants/api_constants.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';
import 'package:kascollection/utils/enums.dart';
import 'package:kascollection/widgets/button_widget.dart';
import 'package:kascollection/widgets/indicator_widget.dart';
import 'package:kascollection/widgets/text_form_widget.dart';
import 'package:kascollection/widgets/title_app_bar_widget.dart';
import 'package:kascollection/widgets/toast_widget.dart';

@RoutePage()
class ChangeMpinScreen extends StatefulWidget {
 
  @override
  State<ChangeMpinScreen> createState() => _ChangeMpihScreenState();
}

class _ChangeMpihScreenState extends State<ChangeMpinScreen> {
  final GlobalKey<FormState> _resetMpinKey = GlobalKey<FormState>();
  TextEditingController createMpinController=TextEditingController();
  TextEditingController confirmMpinController=TextEditingController();
  TextEditingController currentMpinController=TextEditingController();
 void initState() {
    super.initState();
    context.read<ChangeMpinDataCubit>().login(HomeRequestModel(userId: ApiConstant.userId,lang: ApiConstant.langCode));
  }
    late SharedPreferenceHelper sharedPreferenceHelper;
  @override
   
   String? _validateMpin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a MPIN';
    }
    if (value.length != 4) {
      return 'MPIN must be 4 characters';
    }
    //   if (!RegExp(r'^[0-9]{4}$').hasMatch(value)) {
    // //   return 'Please enter a valid 10-digit phone number';
    // }
    return null;
    }
     String? _validateConfirmMpin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a MPIN';
    }
    if (value.length != 4) {
      return 'MPIN must be 4 characters';
    }
   if(value!=createMpinController.text){
    return "Your Mpin and Confirm MPIN doesn't match";
   }
    return null;
    }
    
    void changeMpin() async {
      if (_resetMpinKey.currentState!.validate()) {
      context
          .read<ChangeMpinCubit>()
          .login(ChangeMpinRequestModel(userId:ApiConstant.userId,currentMpin:currentMpinController.text ,
          mpin:createMpinController.text,confirmMpin: confirmMpinController.text,  ));}
    }
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
          BlocListener<ChangeMpinCubit, ChangeMpinState>(
                listener: (context, state) {
                  print(state.networkStatusEnum);
               
          if (state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text=='Success') {
            // sharedPreferenceHelper?.saveUserID(state.registerMpin.data!.id);
            // String userId=sharedPreferenceHelper.getUserId;
            // print('user id----${userId}');
               ToastWidget(message: state.model.message,color: Colors.green,
            ).build(context);
            context.router.pop();
          }
          else if(state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text!='Success'){
           ToastWidget(message: state.model.message).build(context);
            
          }
              }, 
              
          ),
           BlocListener<ChangeMpinDataCubit, ChangeMpinDataState>(
                listener: (context, state) {
                  print(state.networkStatusEnum);
               
          if (state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text=='Success') {
            // sharedPreferenceHelper?.saveUserID(state.registerMpin.data!.id);
            // String userId=sharedPreferenceHelper.getUserId;
            // print('user id----${userId}');
               
          }
          else if(state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text!='Success'){
          
            
          }
              }, )],
           child :BlocBuilder<ChangeMpinDataCubit,ChangeMpinDataState>(
             builder: (context, state) {
               if (state.networkStatusEnum == NetworkStatusEnum.loading){
                return CircularProgressIndicatorWidget();
               }
            else if (state.networkStatusEnum == NetworkStatusEnum.loaded){
              var langData=state.model.data?.langData;
              return Scaffold(
      appBar: TitleAppBarWidget(title: langData?.changeMpin),
      body: 
               Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _resetMpinKey,
                child: Column(
                   
                  children: [
                    // LogoWidget(),
                  vericalSpaceLarge,
                   TextForm(
                      controller: currentMpinController,
                      keyboardType: TextInputType.number,
                      labelText: langData?.currentMpin,
                      hintText:  langData?.currentMpin,
                      validating: _validateMpin,
                      type: 'mpin',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextForm(
                      controller: createMpinController,
                      keyboardType: TextInputType.number,
                      labelText: langData?.mpin,
                      hintText: langData?.mpin,
                      validating: _validateMpin,
                      type: 'mpin',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextForm(
                      controller:confirmMpinController,
                      keyboardType: TextInputType.number,
                      labelText: langData?.confirmMpin,
                      hintText: langData?.confirmMpin,
                      validating: _validateConfirmMpin,
                      type: 'mpin',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   
                   
                    
                    ButtonWidget(
                        onPressed: () {
                          changeMpin();
                          
                        },
                        buttonName:langData?.changeMpin??'',
                        buttonColor: appColor,),
                       const SizedBox(
                      height: 20,
                    ),
                     
                  ],
                ),
              ),
            ));
  }
  else{
  return CircularProgressIndicatorWidget();
}
  }

  )
  );
            }
        
      
  }
