import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget ? widget;

    final BuildContext context;
  final ThemeData themeData;

  final TextEditingController textEditingController;
  const CustomInputField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.textEditingController,
      required this.context,
      required this.themeData,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.025,
        ),
        Text(
          title,
          style: themeData.textTheme.bodyText1!.copyWith(
            fontSize: 12
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          padding: EdgeInsets.only(left: width*0.02),
          height: height * 0.075,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.03),
            border: Border.all(
             color: themeData.primaryColor,
              width: 1,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              child: TextFormField(
              
                readOnly: widget == null ? false : true,
                style: themeData.inputDecorationTheme.labelStyle,
                autofocus: false,
                cursorColor: themeData.disabledColor.withAlpha(150),
                controller: textEditingController,
                decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.symmetric(horizontal: width*0.03),
                  hintText: hint,
               
                ),
              ),
            ),
            widget==null?Container():Container(child: widget,)
          ]),
        ),
      ],
    );
  }
}