import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spec/controller/auth_controller.dart';
import 'package:spec/controller/signup_controller.dart';
import 'package:spec/view/page/mogak/mogak_page.dart';

class ProfileController extends GetxController {
  var controller = Get.find<SignupController>();
  var authController = Get.find<AuthController>();

  Dio dio = Dio();
  String baseUrl = 'https://dev.sniperfactory.com';
  final List<String> _positions = ["DEVELOPER", "DESIGNER", "HEADHUNTER"];
  final RxInt _selectedIndex = RxInt(0);

  get selectedIndex => _selectedIndex.value;
  String get _selectedPosition {
    return _positions[_selectedIndex.value];
  }

  void updateIndex(int index) {
    _selectedIndex.value = index;
  }

  // required
  TextEditingController nicknameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  // optional
  TextEditingController linkedInController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController portfolio1Controller = TextEditingController();
  TextEditingController portfolio2Controller = TextEditingController();
  String? avatar;

  createProfile() async {
    String path = '/api/me/profile';
    String nickname = nicknameController.text;
    // String bio = bioController.text;
    String bio = '뭐람';
    String position = _selectedPosition;
    // String? urlGithub = githubController.text;
    // String? urlPortfolio = portfolio1Controller.text;
    // String? urlEtc = portfolio2Controller.text;

    try {
      var res = await dio.post(path, data: {
        'nickname': nickname,
        'bio': bio,
        'position': position,
        'avatar': avatar,
        // urlGithub,
        // urlPortfolio,
        // urlEtc,
      });
      print(res.data);
      if (res.statusCode == 200) {
        if (res.data['status'] == 'success') {
          String newToken = res.data["data"];
          controller.setToken(newToken); //토큰을 업데이트해야함.
          Get.to(const MogakPage());
        } else {
          print(res.data['message']);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //@todo 추후 정리
  getAuth() async {
    try {
      var res = await authController.getToken();
      print(res);
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    dio.options.baseUrl = baseUrl;
    RxString? authToken = RxString(await getAuth() ?? "");
    dio.options.headers['Authorization'] = authToken;
  }
}