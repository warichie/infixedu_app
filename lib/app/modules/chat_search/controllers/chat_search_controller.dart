import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/chat/search_chat_user/search_chat_user.dart';
import 'package:get/get.dart';

class ChatSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxBool searchLoader = false.obs;
  RxList<SearchChatData> searchChatDataList = <SearchChatData>[].obs;

  Future<SearchChatUser?> getSearchChat(String searchKey) async {
    try {
      searchLoader.value = true;
      searchChatDataList.clear();

      final response = await BaseClient().getData(
        url: InfixApi.getChatUserSearch(keyword: searchKey),
        header: GlobalVariable.header,
      );

      SearchChatUser searchChatUser = SearchChatUser.fromJson(response);
      if (searchChatUser.success == true) {
        searchLoader.value = false;
        if (searchChatUser.data!.isNotEmpty) {
          List<SearchChatData> tempList = [];
          for (int i = 0; i < searchChatUser.data!.length; i++) {
            tempList.add(searchChatUser.data![i]);
          }

          searchChatDataList.value = tempList;
          searchChatDataList.refresh();
        }
      }
    } catch (e, t) {
      searchLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchLoader.value = false;
    }
    return SearchChatUser();
  }
}
