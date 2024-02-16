
import 'package:get/get.dart';



//A Self Caching model implemented with Weak Reference for memory optimization example

class UserModel extends GetxController{
  static Map<int, WeakReference<UserModel>> usersCache = {};

  static UserModel cacheUser(UserModel user) {

    UserModel? cachedUser = usersCache[user.id]?.target;
    if (cachedUser != null) {
      cachedUser.updateModal(user);
      return cachedUser;
    } else {
      usersCache[user.id] = WeakReference(user);
      return user;
    }
  }

  int id;
  String name;
  RxBool following;

  UserModel({required this.id, required this.name, required this.following});

  updateModal(UserModel model) {
    following.value = model.following.value;
    name = model.name;
    update();
  }

  toggleFollowing() {
    following.value = !following.value;
    update();
  }

  factory UserModel.fromJson(Map json) {
    return cacheUser(UserModel(
        id: json['id'],
        name: json['name'],
        following: (json['following'] as bool).obs));
  }
}
