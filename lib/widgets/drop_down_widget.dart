import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kascollection/utils/constant.dart';

class DropDownWidget extends HookWidget {
  final String? initialValue;
  final List<String>? items;
  final String? labelText;
  final String? hintText;
  final Function(String?)? onChanged;
  
bool? isValidate;
String? validationMessage;
  DropDownWidget({
    Key? key,
    required this.items,
    this.initialValue,
    required this.labelText,
    this.onChanged,
    this.hintText,
    this.isValidate,
    this.validationMessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = useState<String?>(initialValue);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField<String>(
        validator: isValidate==true
            ? (value) {
                // Apply validation only if isRequired is true
                if (value == null || value.isEmpty) {
                  return validationMessage ?? 'City Required';
                }
                return null;
              }
            : null,
        isDense: true,
        value: value.value,
        items: items?.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: appColor),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Update the local state and call the provided callback
          value.value = newValue;
          if (onChanged != null) {
            onChanged!(newValue);
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appColor),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        style: TextStyle(color: blackColor),
        iconEnabledColor: appColor,
        iconDisabledColor: greyColor,
      ),
    );
  }
}
class  DropDownWidget1 extends StatefulWidget {
  String? hint;
 List<String> items;
 String? size;
 final ValueChanged<String?>? onChanged;
 double? height;
 double? width;
   DropDownWidget1({required this.hint,required this.items,
   required this.onChanged,this.size,
   this.width,
   this.height});

  @override
  State<DropDownWidget1> createState() => _DropDownWidget1State();
}

class _DropDownWidget1State extends State<DropDownWidget1> {
 

String? selectedValue;
final TextEditingController textEditingController = TextEditingController();

@override


@override
Widget build(BuildContext context) {
   double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
  print('selected value$selectedValue');
  return Stack(
    children: [
      Container(
        decoration:BoxDecoration(border: Border.all(width: 1.0),borderRadius: BorderRadius.circular(5))
         ,
         
        child: DropdownButtonHideUnderline(
          
          child: DropdownButton2<String>(
            
            barrierLabel: 'Size',
            alignment: Alignment.centerLeft,
            isExpanded: true,
            
            hint: Text(
             widget.hint??'',
              style: TextStyle(
                fontSize: 12,
                color: greyColor,
              ),
            ),
            items:widget?.items
                .map((item) => DropdownMenuItem(
                  
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ))
                .toList(),
            value:widget.size!=null && (widget?.size?.isNotEmpty??false)? widget.size: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
               
                  widget.size=selectedValue;
                
              });
              if (widget.onChanged != null) {
             widget.onChanged !(selectedValue);
            }},
            buttonStyleData:  ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height:widget.height?? 40,
              width:widget.width?? swidth/2.5,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            
           
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        ),
      ),
 (selectedValue!= null ||widget.size!=null && widget.height==null)?    Positioned(
        right: 5,
      bottom: 2,
      top:2,
        child: IconButton(icon: Icon(Icons.close,),onPressed: (){
 setState(() {
                selectedValue = null;
               
                  widget.size=selectedValue;
                
              });
               if (widget.onChanged != null) {
      widget.onChanged!(selectedValue);
    }
      },)):Container()
    ],
  );
  
}
}