/* import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../../../../configurations/router/router.dart';
import '../../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../../global/constants/strings/api/apiStrings.dart';
import '../../../../../../global/constants/strings/appStrings/appStrings.dart';
import '../../../../../../global/models/user/userModel.dart';
import '../../../../../../global/screen/please_login_screen.dart';
import '../../../../../../global/widgets/cards/profileOrderCard.dart';
import '../../../../../../global/widgets/formWidgets/appButton.dart';
import '../../../../../../global/widgets/formWidgets/appTextField.dart';
import '../../../../../../global/widgets/formWidgets/intlPhoneField.dart';
import '../../../../../../global/widgets/cards/menuCard.dart';
import '../../../../../../global/widgets/formWidgets/appTextButton.dart';
import '../../../../../../packages/intlField/phone_number.dart';

import '../widgets/profileCardShimmer.dart';
import '../widgets/profilePicture.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = locator<ProfileBloc>();
  final UiHelper _uiHelper = locator<UiHelper>();
  final SizeConfig _sizeConfig = locator<SizeConfig>();
  final ProductHiveStorage _productIds = locator<ProductHiveStorage>();
  final SearchHiveStorage _searchHive = locator<SearchHiveStorage>();
  final LocalStorage _localStorage = locator<LocalStorage>();
  final EnvironmentModel _environmentModel = locator<EnvironmentModel>();
  final EnvironmentBloc _environmentBloc = locator<EnvironmentBloc>();
  final InAppReview inAppReview = InAppReview.instance;

  _getProfile() async {
    try {
      (_environmentModel.tokenValue != null)
          ? await _profileBloc.getProfile()
          // ignore: unnecessary_statements
          : null;
    } catch (e) {
      _uiHelper.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EnvironmentModel>(
        stream: _environmentBloc.environmentModel,
        builder: (context, AsyncSnapshot<EnvironmentModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.token != null) {
              _getProfile();
            }
            return !(snapshot.data!.token == null)
                ? ListView(
                    physics: const BouncingScrollPhysics(),
                    children: _uiHelper.listViewAnimator(
                      children: [
                        _profileCard(context),
                        _orderCard(),
                        _menuItems(),
                      ],
                    ),
                  )
                : PleaseLogin(fromProfile: true);
          } else {
            return Container();
          }
        });
  }

  Padding _orderCard() {
    return Padding(
      padding: EdgeInsets.all(_sizeConfig.blockSizeH),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: _uiHelper.boxShadow(),
        ),
        padding: EdgeInsets.all(_sizeConfig.blockSizeH),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ProfileStrings.order,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                ),
                TextButton(
                  child: Row(
                    children: [
                      Text(
                        ProfileStrings.viewAll,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).accentColor,
                        size: _sizeConfig.blockSizeH * 2,
                      )
                    ],
                  ),
                  onPressed: () => Navigator.pushNamed(context, orderHistory),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileOrderCard(
                  iconFromAsset: IconFromAsset.current,
                  title: ProfileStrings.current,
                  onTap: () => Navigator.pushNamed(context, singleStatusHistory,
                      arguments: {'status': 'current'}),
                ),
                ProfileOrderCard(
                  iconFromAsset: IconFromAsset.deliverd,
                  title: ProfileStrings.delivered,
                  onTap: () => Navigator.pushNamed(context, singleStatusHistory,
                      arguments: {'status': 'delivered'}),
                ),
                ProfileOrderCard(
                  iconFromAsset: IconFromAsset.cancelled,
                  title: ProfileStrings.cancelled,
                  onTap: () => Navigator.pushNamed(context, singleStatusHistory,
                      arguments: {'status': 'cancelled'}),
                ),
                ProfileOrderCard(
                  iconFromAsset: IconFromAsset.refund,
                  title: ProfileStrings.refund,
                  onTap: () => Navigator.pushNamed(context, singleStatusHistory,
                      arguments: {'status': 'refunded'}),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleStatusHistory,
                      arguments: {'status': 'review'});
                },
                child: Text(
                  'Leave Feedback',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimationLimiter _menuItems() {
    final crossAxisCount = 3;
    return AnimationLimiter(
      child: GridView(
          clipBehavior: Clip.none,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          children: _uiHelper.listViewAnimator(
            children: [
              MenuCard(
                iconFromAsset: IconFromAsset.edit,
                title: ProfileStrings.editProfile,
                onTap: () => Navigator.pushNamed(context, editProfile),
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.security,
                title: ProfileStrings.privacy,
                onTap: () => Navigator.pushNamed(context, security),
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.myAddress,
                title: ProfileStrings.myAddress,
                onTap: () => Navigator.pushNamed(context, myAddresses),
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.wishlist,
                title: ProfileStrings.myWishlist,
                onTap: () => Navigator.pushNamed(context, wishlist),
              ),

              ///TODO: Auction is pending
              /*  MenuCard(
                  iconFromAsset: IconFromAsset.auction,
                  title: 'Cake Finder',
                  onTap: () => Navigator.pushNamed(
                          context, productsCollectionSlug, arguments: {
                        "title": "dell-vostro-laptops-40073120",
                        "slug": "dell-vostro-laptops-40073120"
                      })), */
              MenuCard(
                iconFromAsset: Icon(
                  Icons.attractions_rounded,
                  size: _sizeConfig.blockSizeH * 5,
                ),
                title: "Roulette",
                onTap: () => {Navigator.pushNamed(context, roulette)},
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.contactUs,
                title: ProfileStrings.contactUs,
                onTap: () => Navigator.pushNamed(context, contact),
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.career,
                title: MenuStrings.career,
                onTap: () => Navigator.pushNamed(context, vacancy),
              ),
              MenuCard(
                iconFromAsset: Icon(
                  Icons.group_rounded,
                  size: _sizeConfig.blockSizeH * 5,
                ),
                title: ProfileStrings.referral,
                onTap: () => Navigator.pushNamed(
                  context,
                  referral,
                ),
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.rateUs,
                title: ProfileStrings.rateUs,
                onTap: () async {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
              ),
              MenuCard(
                iconFromAsset: IconFromAsset.logout,
                title: ProfileStrings.logout,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Logout',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("Are you sure you want to logout?"),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(_sizeConfig.blockSizeW * 2),
                            child: AppTextButton(
                              title: "Logout",
                              onTap: () async {
                                await _searchHive.clearBox();
                                await _productIds.clearBox();

                                await _localStorage.deleteLocalValue(
                                    key: LocalStorageKeys.token);
                                await _localStorage.deleteLocalValue(
                                    key: LocalStorageKeys.username);
                                await _localStorage.deleteLocalValue(
                                    key: LocalStorageKeys.email);
                                await _localStorage.deleteLocalValue(
                                    key: LocalStorageKeys.phoneNo);
                                await _localStorage.deleteLocalValue(
                                    key: LocalStorageKeys.name);
                                await _localStorage.deleteLocalValue(
                                    key: LocalStorageKeys.isLogin);

                                _environmentModel.tokenSet = null;
                                _environmentModel.usernameSet = null;
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  splash,
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(_sizeConfig.blockSizeW * 2),
                            child: AppTextButton(
                              title: "Cancel",
                              textColor: Theme.of(context).disabledColor,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          )),
    );
  }

  StreamBuilder<UserModel> _profileCard(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: _profileBloc.userModel,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          return snapshot.connectionState == ConnectionState.active
              ? Hero(
                  tag: ProfileStrings.profileTag,
                  child: Padding(
                    padding: EdgeInsets.all(_sizeConfig.blockSizeH),
                    child: Container(
                      padding: EdgeInsets.all(_sizeConfig.blockSizeH),
                      height: _sizeConfig.blockSizeW * 55,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius:
                            BorderRadius.circular(_sizeConfig.blockSizeH * 2),
                        boxShadow: _uiHelper.boxShadow(),
                      ),
                      child: Column(
                        children: [
                          _profileDetail(context,
                              name: snapshot.data!.data!.name!,
                              username: snapshot.data!.data!.username!,
                              picture: snapshot.data!.data!.profileImage!,
                              email: snapshot.data!.data!.email!,
                              countryCode:
                                  snapshot.data!.data!.countryCode ?? " ",
                              phoneNo: snapshot.data!.data!.phoneNumber ?? " ",
                              emailVerified:
                                  snapshot.data!.data!.emailVerified ?? false,
                              phoneVerified:
                                  snapshot.data!.data!.phoneVerified ?? false),
                          _uiHelper.divider(),
                          _uiHelper.smallHeight,
                          Expanded(
                            child: _counterDetails(context,
                                views: snapshot.data!.data!.views ?? 0,
                                connections: snapshot.data!.data!.connections,
                                promotions: snapshot.data!.data!.creditAmount,
                                wishlistNo: snapshot.data!.data!.totalWishlist),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : ProfileCardShimmer();
        });
  }

  Row _counterDetails(
    BuildContext context, {
    required int views,
    connections,
    promotions,
    wishlistNo,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
            onTap: () => Navigator.pushNamed(context, viewProfile),
            child: _counter(context,
                title: ProfileStrings.profileViews, value: views)),
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            connection,
            arguments: connections,
          ),
          child: _counter(context,
              title: ProfileStrings.connections, value: connections.length),
        ),
        InkWell(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Do you have voucher?",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextField(
                          labelText: "Enter referral code here.",
                          padding: 0,
                          onChangeParams: (String promotionCode) =>
                              _profileBloc.setPromotionCode(promotionCode),
                        ),
                        Padding(
                          padding: new EdgeInsets.symmetric(
                              horizontal: _sizeConfig.safeBlockH),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: _sizeConfig.screenH / 7.7,
                                child: AppButton(
                                  act: () async {
                                    Navigator.pop(context);
                                  },
                                  initialData: true,
                                  title: "Cancel",
                                  padding: 2,
                                ),
                              ),
                              Container(
                                width: _sizeConfig.screenW / 4,
                                child: AppButton(
                                  act: () async {
                                    try {
                                      _uiHelper.showLoader(context);

                                      final response = await _profileBloc
                                          .updatePromotionCode();
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      _uiHelper.showToast(msg: response);
                                    } catch (e) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      _uiHelper.showToast(msg: e.toString());
                                    }
                                  },
                                  initialData: true,
                                  title: "Reedem",
                                  padding: 2,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: _counter(context,
                title: ProfileStrings.promotion, value: promotions)),
        InkWell(
            onTap: () => Navigator.pushNamed(context, wishlist),
            child: _counter(context,
                title: ProfileStrings.wishlistItems, value: wishlistNo)),
      ],
    );
  }

  Column _counter(BuildContext context,
      {required String title, dynamic value}) {
    return Column(
      children: [
        if (value != null)
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }

  Row _profileDetail(
    BuildContext context, {
    required String username,
    required String name,
    required String email,
    required String phoneNo,
    required String countryCode,
    required String picture,
    required bool emailVerified,
    required bool phoneVerified,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              boxShadow: _uiHelper.boxShadow(),
              borderRadius: BorderRadius.circular(_sizeConfig.blockSizeH * 8)),
          child: ProfilePicture(
            image: picture,
          ),
        ),
        _uiHelper.smallWidth,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              username,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            _uiHelper.smallHeight,
            if (email != " ")
              _iconText(
                context: context,
                icon: Icons.email_outlined,
                title: email,
              ),
            if (!emailVerified && email == " ")
              _changeEmail(context, 'Add Email'),
            if (!emailVerified && email != " ") _verifyEmail(email),
            _uiHelper.smallHeight,
            if (phoneNo != " ")
              _iconText(
                context: context,
                icon: Icons.phone_android_rounded,
                title: countryCode + phoneNo,
              ),
            if (!phoneVerified && phoneNo == " ")
              _changePhone(context, 'Add phone number'),
            if (!phoneVerified && phoneNo != " ")
              _verifyPhone(context, countryCode, phoneNo)
          ],
        )
      ],
    );
  }

  Row _iconText(
      {required BuildContext context,
      required IconData icon,
      required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          size: _sizeConfig.blockSizeH * 2,
          color: Theme.of(context).disabledColor,
        ),
        _uiHelper.smallWidth,
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  _changeEmail(BuildContext context, String title) {
    return InkWell(
      onTap: () async {
        showBottomSheet(
          context: context,
          elevation: _sizeConfig.blockSizeH,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              height: _sizeConfig.screenH * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_sizeConfig.blockSizeH * 4),
                  topRight: Radius.circular(_sizeConfig.blockSizeH * 4),
                ),
                boxShadow: _uiHelper.boxShadow(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTitle(context, ProfileStrings.changeEmail),
                  _uiHelper.smallHeight,
                  AppTextField(
                    labelText: ProfileStrings.enterEmail,
                    prefixIcon: Icon(Icons.email_outlined),
                    stream: _profileBloc.email,
                    onChangeParams: _profileBloc.changeEmail,
                  ),
                  _uiHelper.smallHeight,
                  AppButton(
                      title: ButtonStrings.verify,
                      act: () async {
                        try {
                          _uiHelper.showLoader(context);
                          final _response = await _profileBloc.updateEmail();
                          _uiHelper.showToast(msg: _response);
                          //For poping loader
                          await Navigator.pushNamed(
                              context, emailPinVerification,
                              arguments: _profileBloc.emailValue);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          await _profileBloc.getProfile();
                          //removed splash navigation
                        } catch (e) {
                          Navigator.pop(context); //For poping loader

                          _uiHelper.showToast(msg: e.toString());
                        }
                      },
                      stream: _profileBloc.emailValid),
                ],
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _uiHelper.smallWidth,
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  _verifyEmail(String email) {
    return InkWell(
      onTap: () async {
        try {
          _profileBloc.changeEmail(email);
          final _response = await _profileBloc.resendConfirmation();
          _uiHelper.showToast(msg: _response);
          Navigator.pushNamed(
            context,
            emailPinVerification,
            arguments: email,
          ).then((value) async {
            await _profileBloc.getProfile();
          });
        } catch (e) {
          _uiHelper.showToast(msg: e.toString());
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          'Verify Email',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  _changePhone(BuildContext context, String title) {
    return InkWell(
      onTap: () async {
        showBottomSheet(
          context: context,
          elevation: _sizeConfig.blockSizeH,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              height: _sizeConfig.screenH * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_sizeConfig.blockSizeH * 4),
                  topRight: Radius.circular(_sizeConfig.blockSizeH * 4),
                ),
                boxShadow: _uiHelper.boxShadow(),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTitle(context, ProfileStrings.changePhone),
                    _uiHelper.smallHeight,
                    AppIntlTextField(
                        labelText: ProfileStrings.enterPhone,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(Icons.phone_android_rounded),
                        stream: _profileBloc.phone,
                        onChangeParams: (PhoneNumber phoneNumber) {
                          _profileBloc
                              .changeCountryCode(phoneNumber.countryCode);
                          _profileBloc.changePhone(phoneNumber.number);
                        }),
                    _uiHelper.smallHeight,
                    AppButton(
                        title: ButtonStrings.change,
                        act: () async {
                          try {
                            await _phoneFirebase(context);
                          } catch (e) {
                            debugPrint('exception');
                          }
                        },
                        stream: _profileBloc.phoneValid),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _uiHelper.smallWidth,
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  _verifyPhone(BuildContext context, String countryCode, String number) {
    return InkWell(
      onTap: () async {
        try {
          _profileBloc.changeCountryCode('+' + '$countryCode');
          _profileBloc.changePhone(number);
          await _phoneFirebase(context, isVerify: true);
        } catch (e) {
          _uiHelper.showToast(msg: e.toString());
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          ButtonStrings.verify,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Padding _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _sizeConfig.blockSizeH * 3,
          vertical: _sizeConfig.blockSizeH),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }

  _phoneFirebase(context, {bool isVerify = false}) async {
    try {
      _uiHelper.showLoader(context);
      await _profileBloc.phoneOTP(
        context: context,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          final _userCredential = await _profileBloc
              .firebase.firebaseAuthInstance
              .signInWithCredential(phoneAuthCredential);
          final User? _user = _userCredential.user;
          if (_user != null) {
            try {
              _uiHelper.showToast(msg: UserAuthStrings.autoAuthOTP);
              final val = isVerify
                  ? await _profileBloc.verifyPhone(_user.uid)
                  : await _profileBloc.changePhoneNumber(_user.uid);
              _uiHelper.showToast(msg: val);
              Navigator.pop(context);
              Navigator.pop(context);
              //removed splash navigation
            } catch (e) {
              _uiHelper.showToast(msg: e.toString());
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }
        },
        codeSent: (String verificationId, int? forceToken) async {
          Map<String, dynamic> _arguments = {
            "verificationId": verificationId,
            "forceToken": forceToken,
            "isPhone": true,
            "fromRegister": false,
            'phoneNo': _profileBloc.phoneValue,
            'email': _profileBloc.emailValue,
            'countryCode': _profileBloc.countryCodeValue,
          };
          final _uid = await Navigator.pushNamed(
            context,
            phonePinVerification,
            arguments: _arguments,
          );
          if (_uid != null) {
            try {
              final val = isVerify
                  ? await _profileBloc.verifyPhone(_uid as String)
                  : await _profileBloc.changePhoneNumber(_uid);
              _uiHelper.showToast(msg: val);
              await _profileBloc.getProfile();
              Navigator.pop(context);

              //Navigator.pop(context);
              /* Navigator.pushReplacementNamed(
                context,
                splash,
              ); */
            } catch (e) {
              _uiHelper.showToast(msg: e.toString());
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }
        },
        codeAutoRetrieval: (String verificationId) {
          //TODO: Verify and set autoretrieval code.
          // _uiHelper.appToast(msg: verificationId);
        },
      );
    } catch (e) {
      _uiHelper.showToast(msg: e.toString());
      Navigator.pop(context);
    }
  }
}
 */
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Profile');
  }
}
