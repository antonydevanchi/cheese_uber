import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cheez/Resources/Constants.dart';
import 'package:flutter_cheez/Resources/Resources.dart';
import 'package:flutter_cheez/Utils/SharedValue.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldText.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'CustomInputField.dart';
import 'Forms.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
class InputFieldName extends StatefulWidget {
  final String label;
  final SharedValue<String> value;
  final double height;
  final bool decorated;
  TextEditingController _controller = new TextEditingController();

  InputFieldName({Key key,this.value,this.label,this.height = 45,this.decorated = true}) : super(key: key){
    _controller.text = value?.value;
  }

  @override
  _InputFieldNameState createState() => _InputFieldNameState();
}



class _InputFieldNameState extends State<InputFieldName> {

  List<String> suggestions = List<String>();


  String response = '';
  String currentText;
  String validateText(String value){


    if(value.length<3){
      return "Имя должно быть больше 3х символов ";
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    var textField = TextFormField(

     // initialValue: widget.value.value,
      controller:widget._controller,
      textAlignVertical: TextAlignVertical.center,
      /* inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          _mobileFormatter,
        ],*/
      style:   TextStyle(fontSize: 14,color:ColorConstants.black,fontWeight: FontWeight.w500,),
      keyboardType: TextInputType.text,
     // obscureText: true,

      decoration: InputDecoration(

        errorStyle: TextStyle(height: 0),
        filled: true,
        fillColor: ColorConstants.mainAppColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.decorated?ColorConstants.darckBlack:ColorConstants.mainAppColor,
            )) ,
        border: OutlineInputBorder(
            borderSide: BorderSide(color:   widget.decorated?ColorConstants.darckBlack:ColorConstants.mainAppColor,)),
        enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color:   widget.decorated?ColorConstants.darckBlack:ColorConstants.mainAppColor,)),
        contentPadding: EdgeInsets.only(left: 10),

        hintText: widget.label,
        suffixIcon: Icon(
          Icons.create,
          color: ColorConstants.darkGray,
          size: 16,
        ),
      ),
      validator: validateText,
      onChanged: (String value) => {
        widget.value.value = value
      },
      //controller: queryController,
    );

    return Container(height: widget.height, child: textField);
  }


}
