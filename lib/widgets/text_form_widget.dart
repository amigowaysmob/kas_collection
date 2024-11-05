
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kascollection/utils/constant.dart';



class TextForm extends StatefulWidget {
  final String? labelText;
  final String ?hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  final String? Function(String?)? validating;
  String? defaultValue;
final String? Function(String?)? onSaved;
IconData? iconData;
bool? readOnly;
VoidCallback? onTap;
int? maxLines;
String? type;
double? padding;
TextAlign? textAlign;
final String? Function(String?)? onChanged;

double?fontSize;
 TextForm({
    super.key,
 this.controller,
    required this.keyboardType,
     this.labelText,
  this.hintText,
     this.validating,
     this.defaultValue,
     this.onSaved,
     this.iconData,
     this.readOnly,
     this.onTap,
     this.maxLines,
     this.type,
     this.onChanged,
     this.textAlign,
this.padding,
this.fontSize
  });

  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    // Set _obscureText to true if labelText is "Password"
    if (widget.labelText == 'Password') {
      _obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
     List<TextInputFormatter> inputFormatters = [];
    if(widget.type == 'mobileNumber') {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
    }
     if(widget.type == 'mpin') {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ];
      
    }
     if(widget.type == 'pincode') {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ];
      
    }
   var isFirstTime=true;
  if(widget.defaultValue?.isNotEmpty ==true && widget. controller?.text.isEmpty == true && isFirstTime){
    widget.  controller?.text =widget. defaultValue??"";
      isFirstTime = false;
    }
    return TextFormField(
      onSaved:widget. onSaved,
      controller: widget.controller,
      obscureText: _obscureText, // Use the class-level _obscureText
      textInputAction: TextInputAction.next,
      onTap: widget.onTap,
      maxLines: widget.maxLines??1,
       textAlign: widget.textAlign?? TextAlign.start,
      style: TextStyle(fontSize: widget.fontSize,),
    
      onChanged: widget.onChanged,
       inputFormatters:inputFormatters,
      keyboardType: widget.keyboardType,
    readOnly: widget.readOnly??false,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(color: appColor),
        isDense: true,
        filled: true,
         contentPadding: EdgeInsets.all(widget.padding??12),
       fillColor: whiteColor,
        labelText: widget.labelText,
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
        
        hintStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: widget.labelText == 'Password'
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null, // No suffix icon for other fields
      ),
      validator: widget.validating,
    );
  }
}
