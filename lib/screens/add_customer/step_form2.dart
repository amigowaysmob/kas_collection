import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kas/src/config/domain/models/request_models/stepper_form_request_model.dart';
import 'package:kas/src/presentation/views/add_customer/heading_widget.dart';
import 'package:kas/src/presentation/views/add_customer/stepper_form1.dart';
import 'package:kas/src/presentation/views/utils/constant.dart';
import 'package:kas/src/presentation/widgets/drop_down_widget.dart';
import 'package:kas/src/presentation/widgets/text_form_widget.dart';
import 'package:kas/src/presentation/widgets/text_view_medium.dart';
import 'package:kas/src/presentation/widgets/text_view_small.dart';

import '../../../config/domain/models/response_models/customer_form_field_model.dart';
import 'package:path/path.dart' as path;



class Step2Form extends HookWidget {
  final GlobalKey<FormState> formKey;
  final StepperFormRequestModel formData;
  Data? data;
  LangData? langData;
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier<DateTime?>(null);
  TextEditingController dobController = TextEditingController();
  Step2Form({required this.formKey, required this.formData, this.data});
  

  @override
  Widget build(BuildContext context) {
   print('step2');
    langData = data?.langData;
     String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return langData?.nameRequired;
    }

    return null;
  }
   String? _validatepin(String? value) {
    if (value == null || value.isEmpty) {
      return langData?.pincodeRequired;
    }

    return null;
  }
   String? _validatecity(String? value) {
    if (value == null || value.isEmpty) {
      return langData?.cityRequired;
    }

    return null;
  }
  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return langData?.addressRequired;
    }

    return null;
  }
    String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return langData?.nameRequired;
    }

    return null;
  }
   String? _validateWhatsapp(String? value) {
    if (value == null || value.isEmpty) {
      return langData?.whatsappRequired;
    }
else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
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
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      }
    }

    final isBottomSheetVisible = useState(false);
    final imagePath = useState<File?>(null);
    final picker = ImagePicker();
     var isIdSelected=useState(false);
  ValueNotifier<String?> idError=useState(null);
    final districtData =
        data?.districtData!.map<String>((type) => type.name!).toList();
    Future<void> getImage(
      ImageSource source,String? title,String? idType
    ) async {
      final image = await picker.pickImage(source: source);
     if (image != null) {
    imagePath.value = File(image.path);
    // Ensure the file path is set in formData
    if (title == langData?.nomineePhoto) {
      formData.nomineePhoto = imagePath.value; // Save customer photo
    } else if (title == langData?.idProofPhotoFront && idType==langData?.aadharCard) {
      formData.nomineeAadharCardFront = imagePath.value; // Save Aadhar front
    } else if (title == langData?.idProofPhotoBack && idType==langData?.aadharCard) {
      formData.nomineeAadharCardBack = imagePath.value; // Save Aadhar back
    }
    else if (title == langData?.idProofPhotoFront && idType==langData?.panCard) {
      formData.nomineePanCardFront = imagePath.value; // Save Aadhar front
    }
     else if (title == langData?.idProofPhotoBack && idType==langData?.panCard) {
      formData.nomineePanCardBack = imagePath.value; // Save Aadhar back
    }
  }
  print('formData.photo ${formData.photo}');
   print('formData.aadhar front ${formData.nomineeAadharCardFront}');
    print('formData.aashr back ${formData.nomineeAadharCardBack}');
    print('formData.pan front ${formData.nomineePanCardFront}');
    print('formData.pan back ${formData.nomineePanCardBack}');
    }

    Future<void> showImagePickerOptions(BuildContext context,String? title,String? idType) async {
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
                    getImage(ImageSource.camera,title,idType);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery,title,idType);
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
    
    return 
 data!=null?    Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingWidget(title: langData?.nomineeRegistrationForm),
          vericalSpaceLarge,
          TextForm(
            keyboardType: TextInputType.name,
            labelText: '${langData?.nomineeName}',
            // validating: _validateUsername,
            onSaved: (value) => formData.nomineeName = value,
          ),
          vericalSpaceLarge,
        

          TextForm(
            keyboardType: TextInputType.number,
            labelText: '${langData?.mobileNumber}',
            // validating: _validateUsername,
            onSaved: (value) => formData.nomineeMobileNumber = value,
          ),
          vericalSpaceLarge,
          TextForm(
            keyboardType: TextInputType.text,
            labelText: langData?.relationship,
            // validating: _validateUsername,
            onSaved: (value) => formData.nomineeRelationship = value,
          ),
          vericalSpaceLarge,
          TextViewMedium(
            name: '${langData?.gender}',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: TextViewSmall(title: langData?.male),
                  value: 'Male',
                  groupValue: selectedGender.value,
                  onChanged: (value) {
                    selectedGender.value = value;
                    formData.nomineeGender = value;
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
                    formData.nomineeGender = value;
                  },
                ),
              ),
             
            ],
          ),
        
vericalSpaceLarge,
         
          TextForm(
            keyboardType: TextInputType.text,
            labelText: '${langData?.city}',
            onSaved: (value) => formData.nomineeCity = value,
            // validating: _validateUsername,
          ),
          vericalSpaceLarge,
          TextForm(
            keyboardType: TextInputType.text,
            labelText: '${langData?.address1}',
            onSaved: (value) => formData.nomineeAddress = value,
            // validating: _validateUsername,
          ),
          vericalSpaceLarge,
          TextForm(
            keyboardType: TextInputType.text,
            labelText: langData?.address2,
            onSaved: (value) => formData.nomineeAddress2 = value,
          ),
          vericalSpaceLarge,
          TextForm(
            keyboardType: TextInputType.text,
            labelText: langData?.landmark,
            onSaved: (value) => formData.landmark = value,
          ),
          vericalSpaceLarge,
          TextViewMedium(
            name: '${langData?.nomineePhoto}',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              PhotoContainerWidget(
                  title: langData?.nomineePhoto,
                  onTap: () {
                    showImagePickerOptions(context,langData?.nomineePhoto,formData.customerIdType);
                    
                  }),
                   formData.nomineePhoto!= null
                            ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  child: Image.file(
                                    formData.photo!,
                                   height: sheight / 6,
                                                  width: swidth / 3,
                                  ),
                                ),
                              )
                            : Container(),
            ],
          ),
          TextViewMedium(
            name: '${langData?.idProofPhoto}',
            fontWeight: FontWeight.bold,
          ),
          Row(
  children: [
    Expanded(
      child: RadioListTile<String>(
        title: TextViewSmall(title: langData?.aadharCard),
        value: langData!.aadharCard??'',
        groupValue: selectedCard.value, // Ensure this matches one of the RadioListTile values
        onChanged: (value) {
          if (value != null) {
            selectedCard.value = value;
            formData.nomineeIdType = value;
            isIdSelected.value=true; 
              formData.nomineeAadharCardFront=null;
                                     formData.nomineeAadharCardBack=null;
                                     formData.nomineePanCardFront=null;
                                     formData.nomineePanCardBack=null; 
            // Assuming you want to store the selected value in formData
          }
        },
      ),
    ),
    Expanded(
      child: RadioListTile<String>(
        title: TextViewSmall(title: langData?.panCard),
        value: langData?.panCard??'',
        groupValue: selectedCard.value, // Ensure this matches one of the RadioListTile values
        onChanged: (value) {
          if (value != null) {
            selectedCard.value = value;
            formData.nomineeIdType = value; 
             isIdSelected.value=true; 
               formData.nomineeAadharCardFront=null;
                                     formData.nomineeAadharCardBack=null;
                                     formData.nomineePanCardFront=null;
                                     formData.nomineePanCardBack=null;// Assuming you want to store the selected value in formData
          }
        },
      ),
    ),
  ],
),

          Row(
            children: [
              PhotoContainerWidget(
                title: langData?.idProofPhotoFront,
                onTap: () {
                  print(isIdSelected.value);
                if(isIdSelected.value==true)
                {
                  idError.value=null;
                showImagePickerOptions(context,langData?.idProofPhotoFront,formData.nomineeIdType);
                }
                else{
                   idError.value=langData?.idTypeRequired;
                }
                 
                 
                },
              ),
              PhotoContainerWidget(
                  title: langData?.idProofPhotoBack,
                  onTap: () {
                    
                      if(isIdSelected.value==true)
                {
                  idError.value=null;
               showImagePickerOptions(context,langData?.idProofPhotoBack,formData.nomineeIdType);} else{
                   idError.value=langData?.idTypeRequired;
                }
                  }),
            ],
          ),
            idError.value!=null?TextViewSmall(title: idError.value,textcolor: Colors.red,):Container(),
           Row(
            children: [
             
               formData.nomineeAadharCardFront!=null&& formData.nomineeAadharCardFront!.existsSync()? Padding(
                padding:  EdgeInsets.all(8.0.r),
                child: Container(
                  width: swidth/2.5,
                  child: Row(
                  children: [
                    Image.file(formData.nomineeAadharCardFront!,height: sheight / 6,
                width: swidth / 3,),
                  
                  ],
                ) ,),
              ): formData.nomineePanCardFront!=null&& formData.nomineePanCardFront!.existsSync()?  Container(
                width: swidth/2.5,
                child: Row(
                  children: [
                    Image.file(formData.nomineePanCardFront!,height: sheight / 6,
                width: swidth / 3,),
                  
                  ],
                ) ,):Container(),
              formData.nomineeAadharCardBack!=null&& formData.nomineeAadharCardBack!.existsSync()? Padding(
                                    padding:  EdgeInsets.all(8.0.r),
                                    child: Container(
               width: swidth/2.8,
               child: Row(
               children: [
                 Image.file(formData.nomineeAadharCardBack!,height: sheight / 6,
                width: swidth / 3,),
               
               
               ],
                                    ) ,),
                                  ): formData.nomineePanCardBack!=null&& formData.nomineePanCardBack!.existsSync()?  Container(
                                     width: swidth/2.8,
                                    child: Row(
               children: [
                 Image.file(formData.nomineePanCardBack!,height: sheight / 6,
                width: swidth / 3,),
                
               
               ],
                                    ) ,):Container(),
            ],
          ),
          // Add other fields as needed
        ],
      ),
    ):Center(child: CircularProgressIndicator(color: appColor,));
  }
}

