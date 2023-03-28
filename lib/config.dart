import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

List messages = [].obs;
RxInt statusCode = 200.obs;
String apiUrl = 'https://gpt-api.01r.cc';
// String apiUrl = 'https://api.openai.com';
String key = '';
SharedPreferences? local;

save() async {
  local = await SharedPreferences.getInstance();
  local?.setString('key', key);
  local?.setString('apiUrl', apiUrl);
}

load() async {
  local = await SharedPreferences.getInstance();
  key = local?.getString('key') ?? '';
  apiUrl = local?.getString('apiUrl') ?? apiUrl;
}
