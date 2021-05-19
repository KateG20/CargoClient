import '../entity/User.dart';

class LocalUserProvider {
  // static late User user;
  //
  // // static late String jSessionId;
  // static String? jSessionId;


  // static void setUser(User user) {
  //   LocalUserProvider.user = user;
  // }
  //
  // static void setJSessionId(String jSessionId) {
  //   LocalUserProvider.jSessionId = jSessionId;
  // }

  static late User user;
  static late String jSessionId;

  // static final LocalUserProvider _singleton = LocalUserProvider._internal();
  // factory LocalUserProvider() => _singleton;
  // LocalUserProvider._internal();
  // static LocalUserProvider get shared => _singleton;

  // void doSomething() {
  //   print('doSomething in SingletonWithPublicStaticField');
  // }

// static LocalUserProvider? _instance;
//
// LocalUserProvider._internal() {
//
//   // name="Singleton pattern";
// }
//
// static LocalUserProvider get instance {
//   if(_instance == null) {
//     _instance = LocalUserProvider._internal();
//   }
//   return _instance!;
// }
}