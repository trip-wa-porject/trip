import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripflutter/models/user_model.dart';

import '../../consts.dart';
import '../../modules/auth_service.dart';
import '../../modules/hike_repository.dart';

class ProfilePageController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final BackendRepository repository = BackendRepository();

  final box = GetStorage();

  signOut() async {
    await box.remove('user');
    Get.find<FirebaseAuthService>().signOut();
    Get.offAndToNamed(AppLinks.LOGIN);
  }

  Future<UserModel?> getUserData(User? user) async {
    if (user == null) {
      return null;
    }
    Map<String, dynamic> data = await repository.getUserUseInstance(user.uid);
    return UserModel.fromJson(data);
  }

  @override
  void onInit() {
    ever(_firebaseAuthService.user, getUserData);
    super.onInit();
  }
}
