import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  RxString role = ''.obs;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signup(
    String email,
    String password,
    String name,
    String role,
  ) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db.collection("users").doc(userCred.user!.uid).set({
        "name": name,
        "email": email,
        "role": role,
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await fetchUserRole();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<String?> fetchUserRole() async {
    if (_auth.currentUser != null) {
      var doc = await _db.collection("users").doc(_auth.currentUser!.uid).get();
      role.value = doc["role"];
      return doc["role"];
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
