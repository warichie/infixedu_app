import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../data/constants/image_path.dart';
import '../../../data/module_data/home_data/home_dummy_data.dart';

class LeaveController extends GetxController {

  final selectIndex = RxInt(-1);


  List<HomeTileModelClass> leaveTileList = [

    if(Get.find<GlobalRxVariableController>().roleId.value == 2)
      HomeTileModelClass(icon: ImagePath.applyLeave, title: 'Apply Leave', value: 'Apply Leave'),
    HomeTileModelClass(icon: ImagePath.list, title: 'Leave List', value: 'Leave List'),
  ];

}
