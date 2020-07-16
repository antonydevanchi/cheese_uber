import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cheez/Resources/Constants.dart';
import 'package:flutter_cheez/Resources/Resources.dart';
import 'package:flutter_cheez/Utils/SharedValue.dart';
import 'package:flutter_cheez/Widgets/Buttons/Buttons.dart';
import 'package:flutter_cheez/Widgets/Buttons/CustomCheckBox.dart';
import 'package:flutter_cheez/Widgets/Forms/Forms.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldCheckBox.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldEmail.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldName.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldPassword.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldPhone.dart';
import 'package:flutter_cheez/Widgets/Forms/InputFieldText.dart';
import 'package:flutter_cheez/Widgets/Forms/NewAddres.dart';
import 'package:flutter_cheez/Widgets/Forms/NextPageAppBar.dart';

import 'OrdersPage.dart';

class UserInfo extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  State<StatefulWidget> createState() =>_UserInfoState();

}
class _UserInfoState extends State<UserInfo> {
  SharedValue<String> phone =   SharedValue<String>(value:Resources().userProfile?.phone);
  SharedValue<String> email=   SharedValue<String>(value: Resources().userProfile?.email);
  SharedValue<String> pass=   SharedValue<String>(value:"");
  SharedValue<String> name =   SharedValue<String>(value:Resources().userProfile?.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorConstants.background,
      appBar: NextPageAppBar(
        height: ParametersConstants.appBarHeight,
        title: TextConstants.profileHeader,
      ),
      body: Center(
        child: Container(
          width: 9999,
          // height: 9999,
          decoration: ParametersConstants.BoxShadowDecoration,
          margin: const EdgeInsets.all(20),

          child: Form(
            key:widget._formKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText.black20pxBold(Resources().userProfile.username),
                      CustomText.black16px(Resources().userProfile.email),

                    ],
                  ),
                ),
                Container(

                  height: 1,
                  color: ColorConstants.gray,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(

                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute( builder: (context) => OrdersPage()));
                      },

                      child: CustomText.black16px(TextConstants.orderHeader)),
                ),
                Container(
                  height: 1,
                  color: ColorConstants.gray,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      CustomText.black16px(TextConstants.bonusPoint),
                      Expanded(child: Container(),),
                      CustomText.black16px(Resources().userProfile.bonusPoints.toString()+TextConstants.pricePostfix),
                    ],
                  ),
                ),
                Container(

                  height: 1,
                  color: ColorConstants.gray,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 16, 16, 16),
                  child: CustomText.black20pxBold(TextConstants.contactDate),
                ),
                Container(

                  height: 1,
                  color: ColorConstants.gray,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child:InputFieldName(label: TextConstants.contactName, value: name,decorated: false),
                ),
                Container(

                  height: 1,
                  color: ColorConstants.gray,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child:InputFieldPhone(label: TextConstants.phone, value: phone,decorated: false),
                ),
                Container(
                  height: 1,
                  color: ColorConstants.gray,
                ),
              /*  Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomText.black16px(Resources().userProfile?.email),
                ),
                Container(

                  height: 1,
                  color: ColorConstants.gray,
                ),
               Padding(
                  padding: const EdgeInsets.all(0),
                  child:InputFieldPassword(label: TextConstants.changePassword, value: pass,decorated: false),
                ),*/

                  Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomText.black20pxBold(TextConstants.youAdresHeader),
                ),
                Container(
                  height: 1,
                  color: ColorConstants.gray,
                ),

                Expanded(child: Container( child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: Resources().userProfile.userAddress == null?0: Resources().userProfile.userAddress.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        color: ColorConstants.gray,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Row(

                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(

                                  onTap: () => {
                                    Navigator.of(context).push(new MaterialPageRoute(builder:(context){ return  NewAddres(userAddress:Resources().userProfile.userAddress[index]);}))
                                  },

                                  child: CustomText.black16px(Resources().userProfile.userAddress[index].name)),
                            ),
                          ),
                        //  CustomCheckBox(disabledWidget: AssetsConstants.toggleOff,enabledWidget: AssetsConstants.toggleOn,value: true,)
                        ],
                      );
                    }),),),
                Padding(
                  padding: const EdgeInsets.all(8),

                  child: CustomButton.colored(expanded: true, color:ColorConstants.red,height: 40,child:CustomText.white12px(TextConstants.newAddres),onClick: ()=>{
                    Navigator.push(
                      context,
                      MaterialPageRoute( builder: (context) =>  NewAddres()))}),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
