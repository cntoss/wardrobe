import 'package:wardrobe/configurations/serviceLocator/locator.dart';
import 'package:wardrobe/global/constants/strings/api/apiStrings.dart';

class ProfileRepository {
  final ApiRepository _apiRepository = locator<ApiRepository>();
  final _profileUrls = ProfileUrls();
  final _connectionUrls = ConnectionUrls();

  getProfile() async {
    try {
      final _response = await _apiRepository.getRequest(
        url: _profileUrls.profile,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  getPublicProfile(String username) async {
    try {
      final _response = await _apiRepository.getRequest(
        url: _profileUrls.publicProfile(username),
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  addConnection(String username) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: {
          "username": username,
        },
        url: _connectionUrls.send,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  removeConnection(String username) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: {
          "username": username,
        },
        url: _connectionUrls.remove,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  //*Updates profile details
  updateProfile(Map<String, dynamic> data) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: data,
        url: _profileUrls.updateProfile,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  //*Updates email verified key
  verifyEmail({String? email, String? pin}) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: {"email": email, "code": pin},
        url: _profileUrls.verifyEmail,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  //*Updates email value
  updateEmail(String email) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: {
          "email": email,
        },
        url: _profileUrls.updateEmail,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  resendEmailCode(String email) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: {
          "email": email,
        },
        url: _profileUrls.resendConfirmation,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  //*Updates phone verified key
  verifyPhone(Map<String, dynamic> data) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: data,
        url: _profileUrls.verifyPhone,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  //*Updates phone number value
  updatePhone(Map<String, dynamic> data) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: data,
        url: _profileUrls.updatePhone,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  updateProfileCoverImage({profileImage, coverImage}) async {
    try {
      FormData formData = FormData.fromMap({
        if (profileImage != null)
          "profileImage": await MultipartFile.fromFile(profileImage,
              filename: "my_profile_picture.jpg"),
        if (coverImage != null)
          "coverImage": await MultipartFile.fromFile(coverImage,
              filename: "my_cover_picture.jpg"),
      });
      final _response = await _apiRepository.postRequest(
        body: formData,
        url: _profileUrls.updateProfileImage,
        auth: true,
      );
      return (_response);
    } catch (e) {
      throw e;
    }
  }

  changePassword(Map<String, dynamic> data) async {
    try {
      final _response = await _apiRepository.postRequest(
        body: data,
        url: _profileUrls.changePassword,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  updateOrderImage() {}

  deleteOrderImage() {}

  supportTicket() {}

  myContests() async {
    try {
      final _response = await _apiRepository.getRequest(
        url: _profileUrls.myContest,
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  myContestDetails(int id) async {
    try {
      final _response = await _apiRepository.getRequest(
        url: _profileUrls.myContestDetails(id),
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }

  updatePromotionCode(String? code) async {
    try {
      final _response = await _apiRepository.postRequest(
        url: _profileUrls.redeemVoucher,
        body: {"code": code},
        auth: true,
      );
      return _response;
    } catch (e) {
      throw e;
    }
  }
}
