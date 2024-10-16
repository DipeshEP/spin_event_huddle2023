import 'package:get/get.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/modeluser.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;
  var filteredUsers = <User>[].obs;
  var query = ''.obs;

  void fetchUsers() {
    SpinApi.fetchUser().listen((snapshot) {
      userList.value = snapshot.docs.map((e) => User.fromJson(e.data())).toList();
      userList.sort((a, b) => b.spinTime!.compareTo(a.spinTime!));
      filterUsers(query.value);
    });
  }

  void filterUsers(String query) {
    if (query.isNotEmpty) {
      filteredUsers.value = userList.where((user) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filteredUsers.value = userList;
    }
  }
}
