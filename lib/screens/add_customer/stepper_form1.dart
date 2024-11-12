import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kas/src/config/domain/models/request_models/mobile_check_request_model.dart';
import 'package:kas/src/config/domain/models/request_models/pin_code_request_model.dart';
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart';
import 'package:kas/src/config/domain/models/response_models/customer_form_field_model.dart';
import 'package:kas/src/presentation/cubits/mobile_check_cubit.dart';
import 'package:kas/src/presentation/cubits/pincode_cubit.dart';
import 'package:kas/src/presentation/cubits/wp_check_cubit.dart';
import 'package:kas/src/presentation/states/mobile_check_state.dart';
import 'package:kas/src/presentation/states/pin_code_state.dart';
import 'package:kas/src/presentation/states/wp_check_state.dart';
import 'package:kas/src/presentation/views/add_customer/heading_widget.dart';

import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/views/utils/constants/api_constants.dart';
import 'package:kas/src/presentation/views/utils/enums.dart';
import 'package:kas/src/presentation/widgets/drop_down_widget.dart';
import 'package:kas/src/presentation/widgets/indicator_widget.dart';

import 'package:kas/src/presentation/widgets/text_form_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_medium.dart';
import 'package:kas/src/presentation/widgets/text_view_small.dart';
import 'package:path/path.dart' as path;

class Step1Form extends HookWidget {
  final GlobalKey<FormState> formKey;
  final StepperFormRequestModel formData;
  Data? data;
  LangData? langData;

  Step1Form({required this.formKey, required this.formData, this.data});

  @override
  Widget build(BuildContext context) {
     print('step1');
    final ValueNotifier<DateTime?> _selectedDate =
        ValueNotifier<DateTime?>(null);
    TextEditingController dobController = useTextEditingController();
    TextEditingController districtController = useTextEditingController();
    TextEditingController stateController = useTextEditingController();
    TextEditingController circleController = useTextEditingController();
    TextEditingController? cityController = useTextEditingController();
    TextEditingController? wpController = useTextEditingController();
    TextEditingController? mobileController = useTextEditingController();
    var isWp=useState(false);
    var isNum=useState(false);
    var wpError=useState<String?>(null);
    var numError=useState<String?>(null);
    var isIdSelected = useState(false);
    ValueNotifier<String?> idError = useState(null);
    langData = data?.langData;
    String? _validateUsername(String? value) {
      if (value == null || value.trim().isEmpty) {
        return langData?.nameRequired;
      }

      return null;
    }
 String? _validateGardian(String? value) {
      if (value == null || value.trim().isEmpty) {
        return ApiConstant.langCode!='ta'?'Guardian Name Required':'பாதுகாவலர் பெயர் தேவை';
      }

      return null;
    }
    String? _validatepin(String? value) {
      if (value == null || value.trim().isEmpty) {
        return langData?.pincodeRequired;
      }

      return null;
    }

    String? _validatecity(String? value) {
      if (value == null || value.trim().isEmpty) {
        return langData?.cityRequired;
      }

      return null;
    }

    String? _validateAddress(String? value) {
      if (value == null ||value.trim().isEmpty) {
        return langData?.addressRequired;
      }

      return null;
    }

    String? _validateArea(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'Area Required';
      }

      return null;
    }

    String? validateDob(String? value) {
      if (value == null || value.trim().isEmpty) {
        return langData?.dobRequired;
      }

      return null;
    }

 String? _validateMobile(String? value) {
    
     if (value!=null&&numError.value!=null) {
        return '';
      }
      
      return null;
    }
    String? _validateWhatsapp(String? value) {
      if (value == null ||value.trim().isEmpty) {
        return langData?.whatsappRequired;
      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
        return langData?.numberValidatedRequired;
      }
      else if (wpError.value!=null) {
        return '';
      }
      return null;
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: appColor, // Header background color

              colorScheme: ColorScheme.light(
                primary: appColor, // Header text and button color
              ),
              buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary, // Button text color
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        _selectedDate.value = picked;
        formData.birthday = "${picked.toLocal()}".split(' ')[0];
        dobController.text=DateFormat('dd/MM/yyyy').format(picked);
      }
    }

    final isBottomSheetVisible = useState(false);
    final imagePath = useState<File?>(null);
    final picker = ImagePicker();
    final districtData =
        data?.districtData!.map<String>((type) => type.name!).toList();
    List<String> cityData = [];
    var selectedCityValue = useState<String?>(null);
    Future<void> getImage(
        ImageSource source, String? title, String? idType) async {
      final image = await picker.pickImage(source: source);
      if (image != null) {
        imagePath.value = File(image.path);
        // Ensure the file path is set in formData
        if (title == langData?.customerPhoto) {
          formData.photo = imagePath.value; // Save customer photo
        } else if (title == langData?.idProofPhotoFront &&
            idType == langData?.aadharCard) {
          formData.aadharCardFront = imagePath.value; // Save Aadhar front
        } else if (title == langData?.idProofPhotoBack &&
            idType == langData?.aadharCard) {
          formData.aadharCardBack = imagePath.value; // Save Aadhar back
        } else if (title == langData?.idProofPhotoFront &&
            idType == langData?.panCard) {
          formData.panCardFront = imagePath.value; // Save Aadhar front
        } else if (title == langData?.idProofPhotoBack &&
            idType == langData?.panCard) {
          formData.panCardBack = imagePath.value; // Save Aadhar back
        }
      }
      print('formData.photo ${formData.photo}');
      print('formData.aadhar front ${formData.aadharCardFront}');
      print('formData.aashr back ${formData.aadharCardBack}');
      print('formData.pan front ${formData.panCardFront}');
      print('formData.pan back ${formData.panCardBack}');
    }

    String? _validateImage(File? image, String? type) {
      if (image == null) {
        // return langData?.imageRequired ??
        if (type == 'idFront') {
          return langData?.idProofFrontRequired;
        } else if (type == 'image') {
          return langData?.photoRequired;
        } else if (type == 'idBack') return langData?.idProofBackRequired;
      }
      return null;
    }

    String? _validateGender(String? value) {
      if (value == null || value.isEmpty) {
        return langData?.genderRequired ?? 'Gender is required';
      }
      return null;
    }

    String? _validateId(String? value) {
      if (value == null || value.isEmpty) {
        return langData?.idTypeRequired ?? 'Id type is required';
      }
      return null;
    }

    bool validateImageUploads() {
      bool isValid = true;
      if (formData.customerIdType == langData?.aadharCard) {
        if (formData.aadharCardFront == null ||
            formData.aadharCardBack == null) {
          isValid = false;
        }
      } else if (formData.customerIdType == langData?.panCard) {
        if (formData.panCardFront == null || formData.panCardBack == null) {
          isValid = false;
        }
      }
      return isValid;
    }

    Future<void> showImagePickerOptions(
        BuildContext context, String? title, String? idType) async {
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
                  getImage(ImageSource.camera, title, idType);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery, title, idType);
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

    final selectedGender = useState(formData.gender);
    final selectedCard = useState('');

    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    stateController.text =
        ApiConstant.langCode != 'ta' ? 'TamilNadu' : 'தமிழ்நாடு';
    return data != null
        ? Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 
                HeadingWidget(title: langData?.customerForm),
                vericalSpaceLarge,
                TextForm(
                  keyboardType: TextInputType.name,
                  labelText: '${langData?.fullName}*',
                  validating: _validateUsername,
                  onSaved: (value) => formData.fullName = value,
                ),
                vericalSpaceLarge,
                TextForm(
                  keyboardType: TextInputType.name,
                  labelText:'${ langData?.guardianName}*',
                   validating: _validateGardian,
                  onSaved: (value) => formData.guardianName = value,
                ),
                vericalSpaceLarge,
                TextForm(
                    keyboardType: TextInputType.number,
                    labelText: '${langData?.mobileNumber}',
                      validating: _validateMobile,
                    controller: mobileController,
                     onChanged: (value) {
                       if(mobileController.text.length==10){
                        isNum.value=true;

                        context.read<MobileCheckCubit>().login(MobileCheckRequestModel(
                          userId: ApiConstant.userId,
                          lang: ApiConstant.langCode,
                          mobilenumber: mobileController.text
                        ));
                       }
                     },
                    onSaved: (value) => formData.phoneNumber = value,
                    type: 'mobileNumber'),
                     BlocListener<MobileCheckCubit,MobileCheckState>(
                      listener: (context, state) {
                        if(state.model.text=='Error' ){
                          numError.value=state.model.message;
                          
                          print(numError.value);
                        }
                        else if(state.model.text!='Error'){
numError.value=null;

                        }
                    
                      },
                    
                child:    numError.value!=null?TextViewSmall(title: numError.value,textcolor: Colors.red,fontSizes: 12):Container()),
                vericalSpaceLarge,
                TextForm(
                    keyboardType: TextInputType.number,
                    controller: wpController,
                    labelText: '${langData?.whatsappNumber}*',
                    validating: _validateWhatsapp,
                     onChanged: (value) {
                       if(wpController.text.length==10){
                       
                        context.read<WpCheckCubit>().login(MobileCheckRequestModel(
                          userId: ApiConstant.userId,
                          lang: ApiConstant.langCode,
                          mobilenumber: wpController.text
                        ));
                       }
                     },
                    onSaved: (value) => formData.whatsappNumber = value,
                    type: 'mobileNumber'),
           BlocListener<WpCheckCubit,WpCheckState>(
                      listener: (context, state) {
                        if(state.model.text=='Error' ){
                          wpError.value=state.model.message;
                          
                          
                        }
                        else if(state.model.text!='Error'){
wpError.value=null;

                        }
                    
                      },       child: wpError.value!=null?TextViewSmall(title: wpError.value,textcolor: Colors.red,fontSizes: 12):Container()),
                vericalSpaceLarge,
                TextForm(
                  keyboardType: TextInputType.emailAddress,
                  labelText: langData?.email,
                  // validating: _validateUsername,
                  onSaved: (value) => formData.email = value,
                ),
                vericalSpaceLarge,
                TextViewMedium(
                  name: '${langData?.gender}*',
                  fontWeight: FontWeight.bold,
                ),
                FormField<String>(
                  validator: (value) => _validateGender(selectedGender.value),
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: TextViewSmall(title: langData?.male),
                                value: 'Male',
                                groupValue: selectedGender.value,
                                onChanged: (value) {
                                  selectedGender.value = value;
                                  formFieldState.didChange(value);
                                  formData.gender = value;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: TextViewSmall(title: langData?.female),
                                value: 'Female',
                                groupValue: selectedGender.value,
                                onChanged: (value) {
                                  selectedGender.value = value;
                                  formFieldState.didChange(value);
                                  formData.gender = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        if (formFieldState.hasError)
                          Text(
                            formFieldState.errorText!,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    );
                    
                  },
                ),
                vericalSpaceLarge,
                ValueListenableBuilder<DateTime?>(
                  valueListenable: _selectedDate,
                  builder: (context, value, child) {
                    return TextForm(
                      controller: dobController,
                      keyboardType: TextInputType.none,
                      labelText: langData?.dateOfBirth,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    );
                  },
                ),
                vericalSpaceLarge,
                TextForm(
                  // controller: stateController,
                  keyboardType: TextInputType.text,
                  labelText: langData?.state,
                  // validating: _validateUsername,
                  onSaved: (value) => formData.state = value,
                  controller: stateController,
                  readOnly: true,
                ),
                vericalSpaceLarge,

                TextForm(
                  keyboardType: TextInputType.number,
                  labelText: '${langData?.pincode}*',
                  validating: _validatepin,
                  onChanged: (value) {
                    // Check if the entered value has 6 digits
                    if (value?.length == 6) {
                      // Save the pincode value
                      FocusScope.of(context).unfocus();
                      formData.Pincode = value;
                      selectedCityValue.value = null;
                      context.read<PincodeCubit>().login(
                            PincodeRequestModel(
                              userId: ApiConstant.userId,
                              lang: ApiConstant.langCode,
                              pincode: value,
                            ),
                          );
                    }
                  },
                  onSaved: (value) {
                    formData.Pincode = value;
                  },
                  type: 'pincode',
                ),

                BlocListener<PincodeCubit, PincodeState>(
                  listener: (context, state) {
                    if (state.networkStatusEnum == NetworkStatusEnum.loaded) {
                      districtController.text =
                          state.model.data?.district ?? '';
                      circleController.text = state.model.data?.division ?? '';
                      List? temp = state.model.data?.cities!
                              .map<String>((type) => type)
                              .toList() ??
                          [];
                      for (var vlu in temp) {
                        cityData!.add(vlu);
                      }

                      if (selectedCityValue.value != null &&
                          cityData!.contains(selectedCityValue.value)) {
                        selectedCityValue.value = null;
                        formData.city = null;
                      }
                    }
                  },
                  child: BlocBuilder<PincodeCubit, PincodeState>(
                      builder: (context, state) {
                    print(state.networkStatusEnum);

                    if (state.networkStatusEnum == NetworkStatusEnum.loaded) {
                      return Column(
                        children: [
                          vericalSpaceLarge,
                          TextForm(
                            controller: districtController,
                            keyboardType: TextInputType.text,
                            labelText: '${langData?.district}*',
                            onSaved: (value) => formData.district = value,
                            readOnly: true,
                            // validating: _validateD,
                          ),
                          vericalSpaceLarge,
                          TextForm(
                            controller: circleController,
                            keyboardType: TextInputType.text,
                            labelText: '${langData?.division}*',
                            onSaved: (value) => formData.circle = value,
                            validating: _validatecity,
                            readOnly: true,
                          ),
                          vericalSpaceLarge,
                          // selectedCityValue.value != null
                          //     ? TextForm(
                          //         controller: cityController,
                          //         keyboardType: TextInputType.text,
                          //         labelText: '${langData?.city}*',
                          //         onSaved: (value) => formData.city = value,
                          //         validating: _validatecity,
                          //         readOnly: true,
                          //       )
                          //     :
                          DropDownWidget(
                            items:state.model.data?.cities,
                            initialValue: selectedCityValue.value,
                            labelText:'${ langData?.city}*',
                            hintText:'${ langData?.city}*',
                            isValidate: true,
                            validationMessage: langData?.cityRequired,
                            onChanged: (selectedCity) {
                              final selectedAppointmentTypee =
                                  state.model.data!.cities?.firstWhere(
                                (type) => type == selectedCity,
                              );
                              List temp = state.model.data?.cities!
                                      .map<String>((type) => type)
                                      .toList() ??
                                  [];
                              for (var vlu in temp) {
                                cityData!.add(vlu);
                              }
                              print('cityData ${cityData}');
                              print('selvaluecityyy${selectedCityValue.value}');
                              print('app${selectedAppointmentTypee}');
                              print('selcityyy${selectedCity}');
                              selectedCityValue.value =
                                  selectedAppointmentTypee;
                              cityController.text = selectedCityValue.value!;
                              formData.city = selectedAppointmentTypee;
                              print(
                                  'selvalueaftercityyy${selectedCityValue.value}');
                            },
                          ),
                          // vericalSpaceLarge,
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
                vericalSpaceLarge,

                TextForm(
                  keyboardType: TextInputType.text,
                  labelText: '${langData?.address1}*',
                  onSaved: (value) => formData.address = value,
                  validating: _validateAddress,
                ),
                vericalSpaceLarge,
                TextForm(
                  keyboardType: TextInputType.text,
                  labelText: '${langData?.area}*',
                  onSaved: (value) => formData.area = value,
                  validating: _validateArea,
                ),
                vericalSpaceLarge,
                TextForm(
                  keyboardType: TextInputType.text,
                  labelText: langData?.landmark,
                  onSaved: (value) => formData.landmark = value,
                ),
                vericalSpaceLarge,
                TextViewMedium(
                  name: '${langData?.customerPhoto}*',
                  fontWeight: FontWeight.bold,
                ),

                vericalSpaceMedium,

                FormField<File?>(
                  validator: (value) => _validateImage(formData.photo, 'image'),
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            PhotoContainerWidget(
                              title: langData?.customerPhoto,
                              onTap: () {
                                showImagePickerOptions(
                                    context,
                                    langData?.customerPhoto,
                                    formData.customerIdType);
                              },
                            ),
                            formData.photo != null
                                ? Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Image.file(
                                            formData.photo!,
                                            height: sheight / 6,
                                            width: swidth / 3,
                                          ),
                                          // SizedBox(width: 10),
                                          // Text(path.basename(formData.photo!.path)),
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

                vericalSpaceMedium,

                TextViewMedium(
                  name: '${langData?.idProofPhoto}*',
                  fontWeight: FontWeight.bold,
                ),

                FormField<String>(
                  validator: (value) => _validateId(selectedCard.value),
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title:
                                    TextViewSmall(title: langData?.aadharCard),
                                value: langData!.aadharCard ?? '',
                                groupValue: selectedCard
                                    .value, // Ensure this matches one of the RadioListTile values
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedCard.value = value;
                                    formData.customerIdType = value;
                                    isIdSelected.value = true;
                                    formData.aadharCardFront = null;
                                    formData.aadharCardBack = null;
                                    formData.panCardFront = null;
                                    formData.panCardBack =
                                        null; // Assuming you want to store the selected value in formData
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: TextViewSmall(title: langData?.panCard),
                                value: langData?.panCard ?? '',
                                groupValue: selectedCard
                                    .value, // Ensure this matches one of the RadioListTile values
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedCard.value = value;
                                    formData.customerIdType = value;
                                    isIdSelected.value = true;
                                    formData.aadharCardFront = null;
                                    formData.aadharCardBack = null;
                                    formData.panCardFront = null;
                                    formData.panCardBack =
                                        null; // Assuming you want to store the selected value in formData
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        if (formFieldState.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              formFieldState.errorText!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    );
                  },
                ),
// Similar validation for ID Proof Photos (front and back)
                FormField<File?>(
                  validator: (value) {
                    if (formData.customerIdType == langData?.aadharCard) {
                      final frontValidation =
                          _validateImage(formData.aadharCardFront, 'idFront');
                      final backValidation =
                          _validateImage(formData.aadharCardBack, 'idBack');
                      return frontValidation ?? backValidation;
                    } else if (formData.customerIdType == langData?.panCard) {
                      final frontValidation =
                          _validateImage(formData.panCardFront, 'idFront');
                      final backValidation =
                          _validateImage(formData.panCardBack, 'idBack');
                      return frontValidation ?? backValidation;
                    }
                    return null;
                  },
                  builder: (formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            PhotoContainerWidget(
                              title: langData?.idProofPhotoFront,
                              onTap: () {
                                print(isIdSelected.value);
                                if (isIdSelected.value == true) {
                                  idError.value = null;
                                  showImagePickerOptions(
                                      context,
                                      langData?.idProofPhotoFront,
                                      formData.customerIdType);
                                } else {
                                  idError.value = langData?.idTypeRequired;
                                }
                              },
                            ),
                            SizedBox(width: 10),
                            PhotoContainerWidget(
                                title: langData?.idProofPhotoBack,
                                onTap: () {
                                  if (isIdSelected.value == true) {
                                    idError.value = null;
                                    showImagePickerOptions(
                                        context,
                                        langData?.idProofPhotoBack,
                                        formData.customerIdType);
                                  } else {
                                    idError.value = langData?.idTypeRequired;
                                  }
                                }),
                          ],
                        ),
                        idError.value != null
                            ? TextViewSmall(
                                title: idError.value,
                                textcolor: Colors.red,
                              )
                            : Container(),
                        Row(
                          children: [
                            formData.aadharCardFront != null &&
                                    formData.aadharCardFront!.existsSync()
                                ? Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Container(
                                      width: swidth / 2.5,
                                      child: Row(
                                        children: [
                                          Image.file(
                                            formData.aadharCardFront!,
                                            height: sheight / 6,
                                            width: swidth / 3,
                                          ),
                                          // horizontalSpaceMedium,
                                          //  Expanded(child: TextViewSmall(title:  path.basename(formData.aadharCardFront!.path))),
                                        ],
                                      ),
                                    ),
                                  )
                                : formData.panCardFront != null &&
                                        formData.panCardFront!.existsSync()
                                    ? Container(
                                        width: swidth / 2.5,
                                        child: Row(
                                          children: [
                                            Image.file(
                                              formData.panCardFront!,
                                              height: sheight / 6,
                                              width: swidth / 3,
                                            ),
                                            // horizontalSpaceMedium,
                                            //  Expanded(child: TextViewSmall(title:  path.basename(formData.panCardFront!.path))),
                                          ],
                                        ),
                                      )
                                    : Container(),
                            formData.aadharCardBack != null &&
                                    formData.aadharCardBack!.existsSync()
                                ? Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Container(
                                      width: swidth / 2.8,
                                      child: Row(
                                        children: [
                                          Image.file(
                                            formData.aadharCardBack!,
                                            height: sheight / 6,
                                            width: swidth / 3,
                                          ),
                                          //  horizontalSpaceMedium,
                                          //  Expanded(child: TextViewSmall(title:  path.basename(formData.aadharCardBack!.path))),
                                        ],
                                      ),
                                    ),
                                  )
                                : formData.panCardBack != null &&
                                        formData.panCardBack!.existsSync()
                                    ? Container(
                                        width: swidth / 2.8,
                                        child: Row(
                                          children: [
                                            Image.file(
                                              formData.panCardBack!,
                                              height: sheight / 6,
                                              width: swidth / 3,
                                            ),
                                            //  horizontalSpaceMedium,
                                            //  Expanded(child: TextViewSmall(title:  path.basename(formData.panCardBack!.path))),
                                          ],
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

// Row(children: [
//   PhotoContainerWidget(
//                       title: langData?.idProofPhotoFront,
//                       onTap: () {
//                         showImagePickerOptions(context,langData?.idProofPhotoFront,formData.customerIdType);

//                       },
//                     ),
//                     horizontalSpaceMedium,
//                     PhotoContainerWidget(
//                       title: langData?.idProofPhotoBack,
//                       onTap: () {
//                         showImagePickerOptions(context,langData?.idProofPhotoBack,formData.customerIdType);

//                       }),
// ],),

                // Add other fields as needed
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
            color: appColor,
          ));
  }
}

class PhotoContainerWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  PhotoContainerWidget({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: greyColor, width: 0.5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                height: sheight / 6,
                width: swidth / 3,
              ),
            ),
            Positioned.fill(
              child: Center(
                // This will center the Column
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 50,
                      color: greyColor,
                    ),
                    vericalSpaceSmall,
                    Padding(
                      padding: EdgeInsets.only(left: 15.r),
                      child: TextViewSmall(
                        title: title,
                        textcolor: greyColor,
                        fontSizes: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

