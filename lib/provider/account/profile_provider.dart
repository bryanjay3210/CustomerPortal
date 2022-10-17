import 'package:cp/enum.dart';
import 'package:cp/model/profile/profile.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../repository/account/profile_repository.dart';

class ProfileProvider {
  final profileListState = BehaviorSubject<DataState>.seeded(DataState.initial);
  final emailHasDuplicate = BehaviorSubject<bool>.seeded(false);
  var profile = <Profile>[];

  Future<List<Profile>> getProfile(
      Map<String, dynamic> map, BuildContext context) async {
    profileListState.add(DataState.loading);
    final profileInfo = <Profile>[];
    profile.clear();
    Map<String, dynamic> data =
        await ProfileRepository(map['server']).getProfile(map);
    if (data['Status'] == 'Success') {
      profileInfo.add(Profile.fromJson(data['User']));
      profile.addAll(profileInfo);
    }
    profileListState.add(DataState.success);
    return profileInfo;
  }

  updateProfile(Map<String, dynamic> map, BuildContext context) async {
    profileListState.add(DataState.loading);
    Map<String, dynamic> data =
        await ProfileRepository(map['server']).updateProfile(map);
    if (data['Status'] == 'Success') {
      profileListState.add(DataState.success);
      showToast('Update profile successfully!');
    }
  }

  Future<String> validateEmail(
      Map<String, dynamic> map, BuildContext context) async {
    emailHasDuplicate.add(false);
    Map<String, dynamic> data =
        await ProfileRepository(map['server']).validateEmail(map);
    if (data['Status'] != 'Success') {
      showToast('${data['Status']} Email Address!');
      emailHasDuplicate.add(true);
    }
    return data['Status'].toString();
  }
}
