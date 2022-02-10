import 'package:shared_preferences/shared_preferences.dart';

class GetUserDataClass {
  var classUserId;
  var classUserName;
  var classUseremail;
  var classUserMobileNo;
  var classUserGotra;
  var classUserBirthdate;
  var classUserSakha;
  var classUserPassword;
  var createdUserToken;
  var createdUserToken1;

  Future<List> getUserData() async {
    final getUserData = await SharedPreferences.getInstance();

    classUserId = getUserData.getString("savedUserId");
    classUserName = getUserData.getString("savedUserName");
    classUseremail = getUserData.getString("savedUserEmail");
    classUserMobileNo = getUserData.getString("savedUserMobileNo");
    classUserGotra = getUserData.getString("savedUserGotra");
    classUserBirthdate = getUserData.getString("savedUserBirthDate");
    classUserSakha = getUserData.getString("savedUserSakha");
    classUserPassword = getUserData.getString("savedUserPassword");

    print("SavedUserId = $classUserId");
    print("SavedUserName = $classUserName");
    print("Saveduseremail = $classUseremail");
    print("SaveduserMobileNo = $classUserMobileNo");
    print("SaveduserGotra = $classUserGotra");
    print("SaveduserBirthdate = $classUserBirthdate");
    print("SaveduserSakha = $classUserSakha");
    print("SaveduserPassword = $classUserPassword");

    return [
      classUserId
    ];
  }
}
