import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  getCurrentUser()async{
    return await FirebaseAuth.instance.currentUser!;
  }

  Future logOut()async{
    await FirebaseAuth.instance.signOut();
  }

  Future deleteUser()async{
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }

}