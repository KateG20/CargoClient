import 'entity/User.dart';

class LocalUserProvider {
  static late User user;

  static void setUser(User user) {
    LocalUserProvider.user = user;
  }

  // static User getUser() {
  //   return user;
  // }
}