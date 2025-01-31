import 'package:get/get.dart';
import 'package:infixedu/screens/fees/services/FeesService.dart';
import 'package:infixedu/screens/fees/model/Fee.dart';
import 'package:infixedu/utils/Utils.dart';

class FetchStudentFeesController extends GetxController {
  var totalFee = <double>[].obs;
  var feeList = <FeeElement>[].obs;
  var isLoading = true.obs;
  String? token;

  @override
  void onInit() {
    super.onInit();
    fetchToken();
  }

  void fetchToken() async {
    token = await Utils.getStringValue('token') ?? '';
    fetchTotalFee();
    fetchFee();
  }

  Future<void> fetchTotalFee() async {
    try {
      final id = await Utils.getStringValue('id') ?? '';
      final fees = await FeeService(int.parse(id), token ?? '').fetchTotalFee();
      totalFee.value = fees;
    } catch (e) {
      // Handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFee() async {
    try {
      final id = await Utils.getStringValue('id') ?? '';
      final fees = await FeeService(int.parse(id), token ?? '').fetchFee();
      feeList.value = fees;
    } catch (e) {
      // Handle errors
    } finally {
      isLoading.value = false;
    }
  }
}
