import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:get/get.dart';

class AdminFeesController extends GetxController {
  final selectIndex = RxInt(-1);

  List<HomeTileModelClass> adminFeesTileList = [
    HomeTileModelClass(
        icon: ImagePath.studentWallet,
        title: 'Fees Group',
        value: 'Fees Group'),
    HomeTileModelClass(
        icon: ImagePath.studentWallet, title: 'Fees Type', value: 'Fees Type'),
    HomeTileModelClass(
        icon: ImagePath.studentWallet,
        title: 'Fees Invoice',
        value: 'Fees Invoice List'),
    HomeTileModelClass(
        icon: ImagePath.studentWallet,
        title: 'Bank Payment',
        value: 'Bank Payment'),
    // HomeTileModelClass(icon: ImagePath.studentWallet, title: 'Reports', value: 'Reports'),
  ];
}
