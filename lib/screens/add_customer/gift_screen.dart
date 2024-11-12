import 'dart:ffi';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kas/src/config/domain/models/request_models/gift_deleivery_request_model.dart';
import 'package:kas/src/config/domain/models/request_models/gift_request_model..dart';
import 'package:kas/src/config/router/app_router.gr.dart';
import 'package:kas/src/presentation/cubits/gift_cubit.dart';
import 'package:kas/src/presentation/cubits/gift_delivery_cubit.dart';
import 'package:kas/src/presentation/states/gift_state.dart';
import 'package:kas/src/presentation/views/add_customer/heading_widget.dart';
import 'package:kas/src/presentation/views/add_customer/stepper_form1.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/views/utils/constants/api_constants.dart';
import 'package:kas/src/presentation/views/utils/enums.dart';
import 'package:kas/src/presentation/widgets/button_widget.dart';
import 'package:kas/src/presentation/widgets/divider_widget.dart';
import 'package:kas/src/presentation/widgets/drop_down_widget.dart';
import 'package:kas/src/presentation/widgets/indicator_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_medium.dart';
import 'package:kas/src/presentation/widgets/text_view_small.dart';
import 'package:kas/src/presentation/widgets/title_app_bar_widget.dart';

@RoutePage()
class GiftScreen extends HookWidget {
  String? orderId;
  GiftScreen({this.orderId});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
     double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    // Using `useEffect` to mimic the behavior of `initState`
    var image=useState<String?>(null);
    var choseGift=useState<String?>(null);
    var giftId=useState<String?>(null);
    ValueNotifier? giftImage=useState<File?>(null);
    ValueNotifier? passImage=useState<File?>(null);
      final isBottomSheetVisible = useState(false);
    final imagePath = useState<File?>(null);
    final picker = ImagePicker();
    useEffect(() {
      // Trigger the API call when the widget is first built
      context.read<GiftCubit>().login(GiftRequestModel(
        userId: ApiConstant.userId,
        lang: ApiConstant.langCode,
        orderId: orderId, // Replace with the appropriate value for orderId
      ));
      return null; // No cleanup needed
    }, []);
    Future<void> getImage(
        ImageSource source, String? title) async {
      final image = await picker.pickImage(source: source);
      if (image != null) {
        imagePath.value = File(image.path);
        // Ensure the file path is set in formData
        if (title == "gift") {
          giftImage.value = imagePath.value; // Save customer photo
        } else if (title == "pass") {
          passImage.value= imagePath.value; // Save Aadhar front
        } 
      }
     
    }
     void register() async {
    
    if (formKey.currentState!.validate() ) {
     context.read<GiftDeliveryCubit>().login(GiftDeliveryRequestModel(
                          userId: ApiConstant.userId,
                          orderId: orderId,
                          giftId: giftId.value,
                          deleiverd: giftImage.value,
                          passBook: passImage.value
                        ));
                  context.router.replace(ReceiptScreen(giftid:orderId));
     
    }
  }
 Future<void> showImagePickerOptions(
        BuildContext context, String? title) async {
      isBottomSheetVisible.value = !isBottomSheetVisible.value;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Uncomment if you want to add camera option
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera, title);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery, title);
                },
              ),
            ],
          );
        },
      );
      //  else {
      //   Navigator.pop(context); // Close the bottom sheet if it's already open
      // }
    }

    return BlocConsumer<GiftCubit, GiftState>(
      listener: (context, state) {
        if (state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text == 'Success') {
          // Handle success case
        } else if (state.networkStatusEnum == NetworkStatusEnum.loaded && state.model.text != 'Success') {
          // Handle other loaded case
        }
      },
      builder: (context, state) {
        if (state.networkStatusEnum == NetworkStatusEnum.loading) {
          return CircularProgressIndicatorWidget();
        }
        if (state.networkStatusEnum == NetworkStatusEnum.loaded) {
          var langData = state.model.data?.langData;
          var cusData = state.model.data?.customerDetails;
          var planData = state.model.data?.planSummary;
          var temp = state.model.data?.giftData!
                  .map<String>((type) => type.title ?? '')
                  .toList() ??
              [];
              String? _validateImage(File? image, String? type) {
      if (image == null) {
        // return langData?.imageRequired ??
        if (type == 'gift') {
          return langData?.deliveryProofRequired;
        } else if (type == 'pass') {
          return langData?.passbookRequired;
        } 
      }
      return null;
    }
          return Scaffold(
            appBar: TitleAppBarWidget(title: langData?.gift?? ''), // Update with appropriate title
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                // Add key if needed
                child: Padding(
                  padding:  EdgeInsets.all(screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingWidget(title: langData?.gift),
                      vericalSpaceLarge,
                      TextViewMedium(
                        name: langData?.customerDetails,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      vericalSpaceLarge,
                      Row(
                        children: [
                          TextViewSmall(
                            title: '${langData?.customerName}     :    ',
                            fontWeight: FontWeight.w700,
                          ),
                          TextViewSmall(
                            title: cusData?.name,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      Row(
                        children: [
                          TextViewSmall(
                            title: '${langData?.customerId}     :    ',
                            fontWeight: FontWeight.w700,
                          ),
                          TextViewSmall(
                            title: cusData?.customerId,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      Row(
                        children: [
                          TextViewSmall(
                            title: '${langData?.customerAddress}   : ',
                            fontWeight: FontWeight.w700,
                          ),
                          Expanded(
                            child: TextViewSmall(
                              title: cusData?.customerAddress,
                            ),
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      DividerWidget(color: greyColor),
                      vericalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewMedium(
                            name: langData?.planSummary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      vericalSpaceLarge,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewSmall(
                            title: '${langData?.planName?? ''}',
                          ),
                          TextViewSmall(
                            title: '${planData?.name?? ''}',
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewSmall(
                            title: '${langData?.duration ?? ''}',
                          ),
                          TextViewSmall(
                            title: '${planData?.duration ?? ''}',
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewSmall(
                            title: langData?.due,
                          ),
                          TextViewSmall(
                            title: '${planData?.amount ?? ''}',
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewSmall(
                            title: '${langData?.dueCount ?? ''}',
                          ),
                          TextViewSmall(
                            title: '${planData?.dueCount ?? '0'}',
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      DividerWidget(color: greyColor,),
                      vericalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextViewSmall(
                            title: '${langData?.totalPaid}',
                          ),
                          TextViewSmall(
                            title: '${planData?.paid}',
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      vericalSpaceMedium,
                      DividerWidget(color: greyColor),
                      vericalSpaceLarge,
                      // DropDownWidget(
                      //   items: temp,
                      //   initialValue: choseGift.value,
                      //   labelText: langData?.chooseGift,
                      //   onChanged: (selectedGift) {
                      //     final selectedGiftData = state.model.data!.giftData?.firstWhere(
                      //       (type) => type.title == selectedGift,
                      //     );
                      //     choseGift.value=selectedGift;
                      //     image.value = selectedGiftData?.image;
                      //     giftId.value=selectedGiftData?.id;
                      //     // Handle the selected gift change
                      //   },
                      // ),
                temp.length>0  ?    FormField<String>(
  validator: (value) {
    if (choseGift.value == null || choseGift.value!.isEmpty) {
      // Return an error message if no gift is selected
      return  'Please select a gift.';
    }
    return null; // Return null if validation passes
  },
  builder: (FormFieldState<String> formFieldState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDownWidget(
          items: temp,
          initialValue: choseGift.value,
          labelText: langData?.chooseGift,
          onChanged: (selectedGift) {
            final selectedGiftData = state.model.data!.giftData?.firstWhere(
              (type) => type.title == selectedGift,
            );
            choseGift.value = selectedGift;
            image.value = selectedGiftData?.image;
            giftId.value = selectedGiftData?.id;

            // Notify the FormField that the value has changed
            formFieldState.didChange(selectedGift);
          },
        ),
        if (formFieldState.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              formFieldState.errorText!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  },
):Container(),

                      image.value!=null?Column(
                        children: [
                          vericalSpaceMedium,
                          Image.network(image.value??'',height: sheight/8,width: swidth/3,),
                        ],
                      ):Container(),
                      vericalSpaceMedium,
            temp.length>0  ?          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         TextViewMedium(
                            name: langData?.uploadProof,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                           FormField<File?>(
                                             validator: (value) {
                                            if (giftImage.value == null) {
                               return langData?.deliveryProofRequired ?? 'Delivery proof image is required.';
                             }
                         
                             // Validate the passbook image
                             if (passImage.value == null) {
                               return langData?.passbookRequired ?? 'Passbook image is required.';
                             }
                         
                             return null; // Return null if all validations pass
                                             },
                                             builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  PhotoContainerWidget(
                                    title: langData?.deliveredProof,
                                    onTap: () {
                                    
                                    
                                        showImagePickerOptions(
                                            context,
                                            'gift',
                                           );
                                     
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  PhotoContainerWidget(
                                      title: langData?.passbook,
                                      onTap: () {
                                     
                                          showImagePickerOptions(
                                              context,
                                              'pass',
                                              );
                                      
                                      }),
                                ],
                              ),
                          
                              Row(
                                children: [
                               ( (giftImage.value!=null) && giftImage.value?.existsSync())
                                          
                                      ? Padding(
                                          padding: EdgeInsets.all(8.0.r),
                                          child: Container(
                                            width: swidth / 2.5,
                                            child: Row(
                                              children: [
                                                Image.file(
                                                  giftImage.value,
                                                  height: sheight / 6,
                                                  width: swidth / 3,
                                                ),
                                                // horizontalSpaceMedium,
                                                //  Expanded(child: TextViewSmall(title:  path.basename(formData.aadharCardFront!.path))),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ( (passImage.value!=null) && passImage.value?.existsSync())
                                      ? Padding(
                                          padding: EdgeInsets.all(8.0.r),
                                          child: Container(
                                            width: swidth / 2.8,
                                            child: Row(
                                              children: [
                                                Image.file(
                                                 passImage.value,
                                                  height: sheight / 6,
                                                  width: swidth / 3,
                                                ),
                                                //  horizontalSpaceMedium,
                                                //  Expanded(child: TextViewSmall(title:  path.basename(formData.aadharCardBack!.path))),
                                              ],
                                            ),
                                          ),
                                        )
                                    
                                          : Container(),
                                ],
                              ),
                              if (formFieldState.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    formFieldState.errorText!,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                           
                            ],
                          );
                                             },
                                           ),
                                           vericalSpaceLarge,
                       ],
                     ):Container(),
       temp.length>0  ?            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(onPressed: (){
                        context.read<GiftDeliveryCubit>().login(GiftDeliveryRequestModel(
                          userId: ApiConstant.userId,
                          orderId: orderId,
                          giftId: giftId.value,
                          deleiverd: giftImage.value,
                          passBook: passImage.value
                        ));
                   context.router.replace(ReceiptScreen());
                      }, buttonName: langData?.skip??'',
                      width: swidth/3 ,buttonColor: whiteColor),
                      
                       ButtonWidget(onPressed: 
                        register
                         
                      , buttonName: langData?.submit??'',
                      width: swidth/3 ,buttonColor: appColor),
                  
                    ],
                  ): ButtonWidget(onPressed: 
                        register
                         
                      , buttonName: 'Next',
                      width: swidth ,buttonColor: appColor),
                    ],
                    
                  ),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
