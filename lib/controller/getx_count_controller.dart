import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXCountController extends GetxController{
  static GetXCountController get to => Get.find();
  RxInt count = 0.obs;

  void putNumber(int i){
    count(i);
    debugPrint(count.value.toString());
  }
}