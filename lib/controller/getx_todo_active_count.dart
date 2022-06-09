import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXTodoActiveCount extends GetxController{
  static GetXTodoActiveCount get to => Get.find();
  RxInt count = 0.obs;

  void putNumber(int i){
    count(i);
    debugPrint(count.value.toString());
  }
}