import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'base_url.dart';

class AuthController extends GetxController {
  final createAccountUrl = Uri.parse('$baseUrl/api/users/create-account');
  final signInUrl = Uri.parse('$baseUrl/api/Account/login');
  final addMemoUrl = Uri.parse('$baseUrl/api/users/add-memo');
  final deleteMemoUrl = Uri.parse('$baseUrl/api/users/delete-memo');

  RxBool isSignedIn = false.obs;
  RxString token = ''.obs;
  RxString signedInEmail = ''.obs;
  RxList memos = [].obs;

  Future<String> createAccount(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      var createAccountData = await http.post(createAccountUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'password': password,
          }));

      if (createAccountData.statusCode == 200) {
        return 'success';
      } else {
        return createAccountData.body.toString();
      }
    } catch (ex) {
      return '$ex';
    }
  }

  Future<String> signIn(
    String email,
    String password,
  ) async {
    try {
      var signInData = await http.post(signInUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': email,
            'password': password,
          }));

      if (signInData.statusCode == 200) {
        isSignedIn.value = true;
        var json = jsonDecode(signInData.body);
        token.value = json['token'];
        await setToken(json['token']);

        return 'success';
      } else {
        return signInData.body.toString();
      }
    } catch (ex) {
      return '$ex';
    }
  }

  Future<String> addMemo(String content) async {
    try {
      var addMemoData = await http.post(addMemoUrl,
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': token.value
          },
          body: jsonEncode({'content': content}));

      if (addMemoData.statusCode == 200) {
        final jsonAddMemoData = jsonDecode(addMemoData.body);
        memos.clear();
        memos.addAll(jsonAddMemoData);

        return 'success';
      } else {
        return addMemoData.body;
      }
    } catch (ex) {
      return '$ex';
    }
  }

  Future<String> deleteMemo(int index) async {
    try {
      var deleteMemoData = await http.post(deleteMemoUrl,
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': token.value
          },
          body: jsonEncode({'index': index}));

      if (deleteMemoData.statusCode == 200) {
        final jsonDeleteMemoData = jsonDecode(deleteMemoData.body);
        memos.clear();

        if (!jsonDeleteMemoData.isBlank) {
          memos.addAll(jsonDeleteMemoData);
        }

        return 'success';
      } else {
        return deleteMemoData.body;
      }
    } catch (ex) {
      return '$ex';
    }
  }

  void signOut() {
    Get.offNamed('/home_page');
    memos.clear();
    token.value = '';
    isSignedIn.value = false;
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
