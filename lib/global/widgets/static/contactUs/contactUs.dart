import 'package:wardrobe/global/widgets/static/bloc/staticDataBloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../configurations/serviceLocator/locator.dart';
import '../../formWidgets/app_button.dart';
import '../../formWidgets/app_text_field.dart';
import '../../formWidgets/social_button.dart';
import '../model/contactModel.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final UiHelper _uiHelper = locator<UiHelper>();

  final SizeConfig _sizeConfig = locator<SizeConfig>();

  final StaticDataBloc _staticDataBloc = locator<StaticDataBloc>();

  @override
  void initState() {
    super.initState();
    callContactUs();
  }

  callContactUs() async {
    try {
      await _staticDataBloc.fetchUserData();
      await _staticDataBloc.fetchContactUs();
    } catch (e) {
      _uiHelper.showToast(msg: e.toString().toString()); //added toString
    }
  }

  @override
  void dispose() {
    //_staticDataBloc.resetForm()();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _uiHelper.appBar(context, title: "Contact Us"),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _sizeConfig.blockSizeW * 4,
          vertical: _sizeConfig.blockSizeW * 4,
        ),
        child: StreamBuilder<ContactModel>(
          stream: _staticDataBloc.contactUs,
          builder:
              (BuildContext context, AsyncSnapshot<ContactModel> snapshot) {
            return snapshot.hasData
                ? StreamBuilder<bool>(
                    stream: _staticDataBloc.fetchedLocal,
                    builder: (BuildContext context,
                        AsyncSnapshot<bool> localSnapshot) {
                      return localSnapshot.hasData
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _titleText(context, "Contact Number"),
                                    _uiHelper.smallHeight,
                                    listItems(
                                        snapshot.data!.data!.content!.phone!,
                                        context,
                                        showIcon: false),
                                    _uiHelper.mediumHeight,
                                    _titleText(context, "Email Address"),
                                    _uiHelper.smallHeight,
                                    listItems(
                                        snapshot.data!.data!.content!.email!,
                                        context,
                                        showIcon: false),
                                    _uiHelper.mediumHeight,
                                    _titleText(context, "Find Us On"),
                                    _socialRow(snapshot
                                        .data!.data!.content!.socialMedia!),
                                    _uiHelper.mediumHeight,
                                    _titleText(context, "Write to Us"),
                                    _uiHelper.smallHeight,
                                    AppTextField(
                                      prefixIcon: Icon(Icons.person_outline),
                                      padding: 0,
                                      labelText: "Full Name",
                                      stream: _staticDataBloc.fullName,
                                      initialData: _staticDataBloc.localName,
                                      onChangeParams:
                                          _staticDataBloc.changeFullName,
                                    ),
                                    AppTextField(
                                      prefixIcon:
                                          Icon(Icons.phone_android_rounded),
                                      padding: 0,
                                      labelText: "Phone Number",
                                      keyboardType: TextInputType.phone,
                                      stream: _staticDataBloc.phoneNo,
                                      initialData: _staticDataBloc.localPhone,
                                      onChangeParams:
                                          _staticDataBloc.changePhoneNo,
                                    ),
                                    AppTextField(
                                      prefixIcon: Icon(Icons.email_rounded),
                                      padding: 0,
                                      labelText: "Email",
                                      stream: _staticDataBloc.email,
                                      initialData: _staticDataBloc.localEmail,
                                      onChangeParams:
                                          _staticDataBloc.changeEmail,
                                    ),
                                    AppTextField(
                                      prefixIcon: Icon(Icons.message_rounded),
                                      labelText: "Message",
                                      stream: _staticDataBloc.message,
                                      onChangeParams:
                                          _staticDataBloc.changeMessage,
                                      padding: 0,
                                    ),
                                    AppButton(
                                      title: "Submit",
                                      stream: _staticDataBloc.submitValid,
                                      act: () async {
                                        try {
                                          _uiHelper.hideKeyboard(context);
                                          _uiHelper.showLoader(context);
                                          final response = await _staticDataBloc
                                              .submitForm();
                                          Navigator.pop(context);
                                          _uiHelper.showToast(msg: response);
                                        } catch (e) {
                                          Navigator.pop(context);
                                          _uiHelper.showToast(
                                              msg: e.toString().toString());
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          : _uiHelper.loaderWidget;
                    })
                : Center(child: _uiHelper.loaderWidget);
          },
        ),
      ),
    );
  }

  Row _socialRow(List<SocialMedia> social) {
    return Row(
      children: [
        SocialButton(
            icon: FontAwesomeIcons.facebookF,
            onTap: () async {
              if (await canLaunch(social
                  .where((element) => element.name == "facebook")
                  .first
                  .link!)) {
                launch(social
                    .where((element) => element.name == "facebook")
                    .first
                    .link!);
              } else {
                _uiHelper.showToast(msg: "Sorry unable to open the link.");
              }
            }),
        SocialButton(
            icon: FontAwesomeIcons.instagram,
            onTap: () async {
              if (await canLaunch(social
                  .where((element) => element.name == "instagram")
                  .first
                  .link!)) {
                launch(social
                    .where((element) => element.name == "instagram")
                    .first
                    .link!);
              } else {
                _uiHelper.showToast(msg: "Sorry unable to open the link.");
              }
            }),
        SocialButton(
            icon: FontAwesomeIcons.youtube,
            onTap: () async {
              if (await canLaunch(social
                  .where((element) => element.name == "youtube")
                  .first
                  .link!)) {
                launch(social
                    .where((element) => element.name == "youtube")
                    .first
                    .link!);
              } else {
                _uiHelper.showToast(msg: "Sorry unable to open the link.");
              }
            }),
      ],
    );
  }

  Row listItems(List<Email> itemList, BuildContext context,
      {bool showIcon = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: itemList
              .map((e) => Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${e.type} : ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            e.value!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _sizeConfig.blockSizeW * 2,
                      )
                    ],
                  ))
              .toList(),
        ),
        showIcon
            ? Icon(
                Icons.pin_drop_rounded,
                size: 60,
              )
            : SizedBox()
      ],
    );
  }

  _titleText(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }
}
