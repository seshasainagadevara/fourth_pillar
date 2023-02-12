import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/moulds/user.dart';
import 'package:fourth_pillar/visuals/screens/authentication/login/login_screen.dart';
import 'package:fourth_pillar/visuals/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseAuthController extends GetxController {
  static FirebaseAuthController instance = Get.find<FirebaseAuthController>();
  Rx<File?>? _selectedImage;
  late Rx<User?> _user;
  File? get getProfilePic => _selectedImage?.value;

  User get user => _user.value!;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuthInstance.currentUser);
    _user.bindStream(firebaseAuthInstance.authStateChanges());
    ever(_user, _userStateChanges);
    super.onReady();
  }

  _userStateChanges(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void pickImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar('Profile Picture', 'Profile image selected successfully!');
      _selectedImage = Rx<File?>(File(pickedImage.path));
    }
  }

  Future<String> _uploadToFirebaseStorage(File image) async {
    Reference ref = firebaseStorageInstance
        .ref()
        .child('profilePics')
        .child(firebaseAuthInstance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(String userName, String email, String password,
      {File? image}) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await firebaseAuthInstance
            .createUserWithEmailAndPassword(email: email, password: password);
        String profilePicUrl = await _uploadToFirebaseStorage(image);
        FUser fUser = FUser(
            userName: userName,
            email: email,
            uid: userCredential.user!.uid,
            profilePic: profilePicUrl);

        await firebaseFirestoreInstance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
              fUser.toJson(),
            );
      } else {
        Get.snackbar(
            'Account creation failed !', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Account creation failed !', e.toString());
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuthInstance.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar('Account login failed !', 'Please enter all credentials');
      }
    } catch (e) {
      Get.snackbar('Account login failed !', e.toString());
    }
  }

  void signout() async {
    await firebaseAuthInstance.signOut();
  }
}
