import '../entity/User.dart';

class LocalUserProvider {
  static late User user;
  static String? jSessionId;

  static void setUser(User user) {
    LocalUserProvider.user = user;
  }
}