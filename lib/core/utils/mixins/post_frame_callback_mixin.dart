import 'package:flutter/material.dart';

mixin PostFrameCallbackMixin<T extends StatefulWidget> on State<T>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(onPostFrameCallback);
  }

  void onPostFrameCallback(timeStamp);

}