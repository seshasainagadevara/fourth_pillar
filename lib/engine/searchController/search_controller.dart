import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/moulds/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Rx<List<FUser>> _searchedUsers = Rx<List<FUser>>([]);

  List<FUser> get searchedUsers => _searchedUsers.value;

  clearUsers() {
    _searchedUsers = Rx<List<FUser>>([]);
  }

  searchUser(String typedName) async {
    _searchedUsers.bindStream(firebaseFirestoreInstance
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: typedName)
        .snapshots()
        .map((event) {
      List<FUser> retval = [];
      for (var e in event.docs) {
        retval.add(FUser.getUserFromSnapShot(e));
      }
      return retval;
    }));
  }

  @override
  void onClose() {
    _searchedUsers = Rx<List<FUser>>([]);

    super.onClose();
  }
}
