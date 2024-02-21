
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SimpleUIController extends GetxController {
  RxBool isObscure = true.obs;

  isObscureActive() {
    isObscure.value = !isObscure.value;
  }
}