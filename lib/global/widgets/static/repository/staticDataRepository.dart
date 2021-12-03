import '../model/contactModel.dart';

import '../../../../configurations/serviceLocator/locator.dart';
import '../../../constants/strings/api/apiStrings.dart' show StaticDataUrls;
import '../model/privacyPolicyModel.dart';

export 'package:wardrobe/global/widgets/static/model/privacyPolicyModel.dart';

class StaticDataRepository {
  final ApiRepository _api = locator<ApiRepository>();

  Future<PolicyModel> privacyPolicy() async {
    try {
      final response = await _api.getRequest(
        url: StaticDataUrls().privacyPolicy,
      );
      return PolicyModel.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<PolicyModel> refundPolicy() async {
    try {
      final response = await _api.getRequest(
        url: StaticDataUrls().refundPolicy,
      );
      return PolicyModel.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<ContactModel> contactUs() async {
    try {
      final response = await _api.getRequest(
        url: StaticDataUrls().contactUs,
      );
      return ContactModel.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  contactUsForm(Map<String, dynamic> body) async {
    try {
      final response = await _api.postRequest(
        url: StaticDataUrls().contactForm,
        body: body,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
