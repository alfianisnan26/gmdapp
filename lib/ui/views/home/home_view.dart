import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmdapp/app/constants/assets.dart';
import 'package:gmdapp/app/utils/verificator.dart';
import 'package:gmdapp/ui/views/authentication/sign_in/sign_in_view.dart';
import 'package:gmdapp/ui/views/home/app/drawer_content.dart';
import 'package:gmdapp/ui/views/sidebar/about_view.dart';
import 'package:gmdapp/ui/views/sidebar/help_view.dart';
import 'package:gmdapp/ui/views/sidebar/profile_view.dart';
import 'package:gmdapp/ui/views/sidebar/setting_view.dart';

import '../../../app/constants/strings.dart';
import '../../../app/services/firebase_auth_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  @override
  void initState() {
    print("Logged in as : " + FirebaseAuthService().currentUser().email);
    print("UID          : " + FirebaseAuthService().currentUser().uid);
    print("Display Name : " +
        FirebaseAuthService().currentUser().displayName.toString());
    print("Verified     : " +
        FirebaseAuthService().currentUser().verified.toString());
    print("PhotoURL     : " +
        FirebaseAuthService().currentUser().photoUrl.toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Verify.check(context, dontShow: true, callback: setState));
    super.initState();
  }

  Map<String, Widget> tabs = {
    Strings.administration: null,
    Strings.learning: null
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            drawer: Drawer(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FAS.user.photoUrl != null
                                      ? NetworkImage(FAS.user.photoUrl)
                                      : AssetImage(Assets.links.images.logo),
                                  fit: FAS.user.photoUrl != null
                                      ? BoxFit.cover
                                      : BoxFit.contain),
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        Container(
                            width: 180,
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.hello + ","),
                                  Text(
                                    FAS.displayName,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]))
                      ],
                    )),
                ListTile(
                  title: Text(Strings.profile),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProfileView())),
                ),
                ListTile(
                  title: Text(Strings.setting),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingView())),
                ),
                ListTile(
                  title: Text(Strings.help),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HelpView())),
                ),
                ListTile(
                  enabled: !FirebaseAuthService().currentUser().verified,
                  title: Text(Strings.checkVerification),
                  onTap: () {
                    Navigator.of(context).pop();
                    if (Verify.check(context)) setState(() {});
                  },
                ),
                ListTile(
                  title: Text(Strings.about),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AboutView())),
                ),
                ListTile(
                  title: Text(Strings.exit),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInView()));
                    FirebaseAuthService().signOut();
                  },
                ),
              ],
            )),
            appBar: AppBar(
              title: Text(Strings.dashboard),
              bottom: TabBar(tabs: tabs.keys.map((e) => Tab(text: e)).toList()),
            ),
            body: TabBarView(children: [
              GridView.count(
                  padding: EdgeInsets.all(10),
                  crossAxisCount:
                  (MediaQuery.of(context).size.width / 300).ceil(),
                  children: DrawerAdmin.widget(context)),
              GridView.count(
                  padding: EdgeInsets.all(10),
                  crossAxisCount:
                      (MediaQuery.of(context).size.width / 300).ceil(),
                  children: DrawerApp.widget(context)),
            ])));
  }
}
