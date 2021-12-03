/* import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../configurations/serviceLocator/locator.dart';
import '../../../../../../global/constants/strings/appStrings/appStrings.dart';
import '../../model/publicProfileModel.dart';
import '../widgets/coverPicture.dart';
import '../widgets/profilePicture.dart';

class PublicProfileScreen extends StatefulWidget {
  final String username;

  const PublicProfileScreen({Key? key, required this.username})
      : super(key: key);
  @override
  _PublicProfileScreenState createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  final ProfileBloc _profileBloc = locator<ProfileBloc>();

  final UiHelper _uiHelper = locator<UiHelper>();

  final SizeConfig _sizeConfig = locator<SizeConfig>();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await _profileBloc.getPublicProfile(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: _uiHelper.listViewAnimator(
                  children: [
                    _coverImage(),
                    _profileCard(context),
                    _profileOthersCard(context, "Items in Auction"),
                    _profileOthersCard(context, "Contest Participation"),
                    _profileOthersCard(context, "Quizzes Created"),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<PublicProfileModel> _coverImage() {
    return StreamBuilder<PublicProfileModel>(
        stream: _profileBloc.publicProfile,
        builder:
            (BuildContext context, AsyncSnapshot<PublicProfileModel> snapshot) {
          return snapshot.hasData
              ? CoverImage(
                  image: snapshot.data!.data!.coverImage ?? " ",
                )
              : _uiHelper.addShimmer(
                  child: Container(
                  height: _sizeConfig.blockSizeW * 50,
                  width: _sizeConfig.screenW,
                ));
        });
  }

  Padding _profileOthersCard(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.all(_sizeConfig.blockSizeH),
      child: Container(
        padding: EdgeInsets.all(_sizeConfig.blockSizeH),
        height: _sizeConfig.blockSizeW * 50,
        width: _sizeConfig.screenW,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(_sizeConfig.blockSizeH * 2),
            boxShadow: _uiHelper.boxShadow()),
        child: Text(title, style: Theme.of(context).textTheme.headline1),
      ),
    );
  }

  StreamBuilder<PublicProfileModel> _profileCard(BuildContext context) {
    return StreamBuilder<PublicProfileModel>(
        stream: _profileBloc.publicProfile,
        builder:
            (BuildContext context, AsyncSnapshot<PublicProfileModel> snapshot) {
          return snapshot.hasData
              ? Hero(
                  tag: ProfileStrings.profileTag,
                  child: Padding(
                    padding: EdgeInsets.all(_sizeConfig.blockSizeH),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildProfile(context, snapshot),
                        _profilePicture(context, snapshot),
                      ],
                    ),
                  ),
                )
              : _uiHelper.addShimmer(
                  child: Container(
                  height: _sizeConfig.blockSizeW * 50,
                  width: _sizeConfig.screenW,
                ));
        });
  }

  Container _buildProfile(
      BuildContext context, AsyncSnapshot<PublicProfileModel> snapshot) {
    return Container(
      padding: EdgeInsets.all(_sizeConfig.blockSizeH),
      height: _sizeConfig.blockSizeW * 110,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(_sizeConfig.blockSizeH * 2),
          boxShadow: _uiHelper.boxShadow()),
      child: Column(
        children: [
          _profileDetail(context,
              name: snapshot.data!.data!.name!,
              username: snapshot.data!.data!.username!,
              picture: snapshot.data!.data!.profileImage,
              birthday: snapshot.data!.data!.birthday ?? ""),
          _uiHelper.divider(),
          _uiHelper.smallHeight,
          _counterDetails(context,
              views: snapshot.data!.data!.views!,
              isConnected: snapshot.data!.data!.connection == null
                  ? false
                  : snapshot.data!.data?.connection?.isConnected as bool,
              username: snapshot.data!.data!.username!),
          _uiHelper.divider(),
          _uiHelper.smallHeight,
          Padding(
            padding: EdgeInsets.all(_sizeConfig.blockSizeH * 2),
            child: Text(
              snapshot.data!.data!.bio ?? ProfileStrings.noBio,
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _uiHelper.divider(),
          _uiHelper.smallHeight,
          Text(ProfileStrings.findMe,
              style: Theme.of(context).textTheme.subtitle2),
          Expanded(child: _socialDetails(snapshot.data!.data!.social!))
        ],
      ),
    );
  }

  Positioned _profilePicture(
      BuildContext context, AsyncSnapshot<PublicProfileModel> snapshot) {
    return Positioned(
      top: -_sizeConfig.blockSizeW * 16,
      right: 0,
      child: ProfilePicture(
        image: snapshot.data!.data!.profileImage!,
      ),
    );
  }

  Row _socialDetails(Social social) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _socialButton(
        url: social.facebook!.username ?? "",
        baseurl: ProfileStrings.facebookUrl,
        icon: FontAwesomeIcons.facebookF,
      ),
      _socialButton(
          url: social.instagram!.username ?? "",
          icon: FontAwesomeIcons.instagram,
          baseurl: ProfileStrings.instagramUrl),
      _socialButton(
        url: social.linkedin!.username ?? "",
        icon: FontAwesomeIcons.linkedinIn,
        baseurl: ProfileStrings.linkedInUrl,
      ),
      _socialButton(
          url: social.tiktok!.username ?? '',
          icon: FontAwesomeIcons.tiktok,
          baseurl: ProfileStrings.tiktokUrl),
    ]);
  }

  IconButton _socialButton({String? url, String? baseurl, IconData? icon}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () async {
        if (url != null && baseurl != null) {
          try {
            if (await canLaunch(baseurl + url)) {
              await launch(baseurl + url);
            } else {
              _uiHelper.showToast(msg: ProfileStrings.sorryMessage);
            }
          } catch (e) {
            _uiHelper.showToast(msg: ProfileStrings.sorryMessage);
          }
        }
      },
    );
  }

  Row _counterDetails(BuildContext context,
      {required int views,
      bool isConnected = false,
      required String username}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _counter(
          context,
          title: ProfileStrings.profileViews,
          value: views,
        ),
        isConnected
            ? _counter(
                context,
                onTap: () async {
                  try {
                    final data = await _profileBloc.removeConnection(username);
                    _uiHelper.showToast(msg: data);
                  } catch (e) {
                    _uiHelper.showToast(msg: e.toString());
                  }
                },
                title: ProfileStrings.removeConnections,
                value: '-',
              )
            : _counter(
                context,
                onTap: () async {
                  try {
                    final data = await _profileBloc.addConnection(username);
                    _uiHelper.showToast(msg: data);
                  } catch (e) {
                    _uiHelper.showToast(msg: e.toString());
                  }
                },
                title: ProfileStrings.connect,
                value: "+",
              ),
      ],
    );
  }

  InkWell _counter(BuildContext context,
      {required String title, dynamic value, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: _sizeConfig.blockSizeW * 10,
        child: Column(
          children: [
            Text(
              value != null ? value.toString() : '',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }

  Widget _profileDetail(
    BuildContext context, {
    required String username,
    required String name,
    String? birthday,
    String? picture,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
            _iconText(
              context: context,
              icon: Icons.cake,
              title: birthday == " " || birthday == null
                  ? "Not Defined"
                  : birthday,
            ),
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
}
 */