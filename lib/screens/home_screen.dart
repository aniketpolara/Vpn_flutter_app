import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/helpers/config.dart';

import '../controllers/home_controller.dart';

import '../main.dart';

import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import 'location_screen.dart';
import 'network_test_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AdvancedDrawer(
      backdropColor: HexColor("04293A").withOpacity(0.6),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOutBack,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      drawer: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.0528,
                right: screenWidth * 0.0628,
                top: screenHeight * 0.0666,
                bottom: screenHeight * 0.0333,
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: Image(image: AssetImage("assets/images/logo1.png")),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.01333,
              ),
              child: Text(
                "Super VPN",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "    MADE IN GERMANY WITH ❤️",
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01333,
            ),
            const Divider(
              indent: 15,
              color: Colors.white,
            ),
            ListTile(
              onTap: (() async {
                var url = Uri.parse("https://play.google.com/store/apps/details?id=com.free.vpn.connect.app");
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  throw "Could not launch $url";
                }

                // controller.rateAppUrl();
              }),
              leading: Image.asset(
                "assets/images/star.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                'Rate App',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: (() {
                Share.share("https://play.google.com/store/apps/details?id=com.free.vpn.connect.app");
              }),
              leading: Image.asset(
                "assets/images/network.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                'Share With Friends',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () async {
                var url = Uri.parse("https://supervpnfastvpnproxy.blogspot.com/2023/07/supervpn-fast-proxy.html");
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  throw "Could not launch $url";
                }
                // // controller.termsAndConditionsUrl();
              },
              leading: Image.asset(
                "assets/images/terms.png",
                height: 30,
                width: 30,
              ),

              title: const Text(
                'Terms & Conditions',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: (() {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: "applicationguru1008@gmail.com",
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Frequantly Asked Question',
                  }),
                );
                launchUrl(emailLaunchUri);

                // controller.termsAndConditionsUrl();
              }),
              leading: Image.asset(
                "assets/images/faq.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                'FAQs',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(
              indent: 15,
              color: Colors.white,
            ),
            ListTile(
              onTap: (() {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: "applicationguru1008@gmail.com",
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Help & Support',
                  }),
                );
                launchUrl(emailLaunchUri);

                // controller.launchEmailSubmission();
              }),
              leading: Image.asset(
                "assets/images/help.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                'Customer Support',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: const Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: HexColor("152238"),
        //app bar
        appBar: AppBar(
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Text('Free OpenVPN'),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       //ad dialog
            //       Get.dialog(WatchAdDialog(onComplete: () {
            //         //watch ad to gain reward
            //         AdHelper.showRewardedAd(onComplete: () {
            //           Get.changeThemeMode(
            //               Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            //           Pref.isDarkMode = !Pref.isDarkMode;
            //         });
            //       }));
            //     },
            //     icon: Icon(
            //       Icons.brightness_medium,
            //       size: 26,
            //     )),
            IconButton(
                padding: EdgeInsets.only(right: 8),
                onPressed: () => Get.to(() => NetworkTestScreen()),
                icon: Icon(
                  CupertinoIcons.info,
                  size: 27,
                )),
          ],
        ),

        bottomNavigationBar: _changeLocation(context),

        //body
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //vpn button
          Obx(() => _vpnButton()),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //country flag
                HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty
                        ? 'Country'
                        : _controller.vpn.value.countryLong,
                    subtitle: 'FREE',
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: _controller.vpn.value.countryLong.isEmpty
                          ? Icon(Icons.vpn_lock_rounded,
                              size: 30, color: Colors.white)
                          : null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty
                          ? null
                          : AssetImage(
                              'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                    )),

                //ping time
                HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty
                        ? '100 ms'
                        : '${_controller.vpn.value.ping} ms',
                    subtitle: 'PING',
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.equalizer_rounded,
                          size: 30, color: Colors.white),
                    )),
              ],
            ),
          ),

          StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.vpnStatusSnapshot(),
              builder: (context, snapshot) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //download
                      HomeCard(
                          title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                          subtitle: 'DOWNLOAD',
                          icon: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.lightGreen,
                            child: Icon(Icons.arrow_downward_rounded,
                                size: 30, color: Colors.white),
                          )),

                      //upload
                      HomeCard(
                          title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                          subtitle: 'UPLOAD',
                          icon: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.arrow_upward_rounded,
                                size: 30, color: Colors.white),
                          )),
                    ],
                  ))
        ]),
      ),
    );
  }

  //vpn button
  Widget _vpnButton() => Column(
        children: [
          //button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.2)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.3)),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Icon(
                          Icons.power_settings_new,
                          size: 28,
                          color: Colors.white,
                        ),

                        SizedBox(height: 4),

                        //text
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          //connection status label
          Container(
            margin:
                EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            ),
          ),

          //count down timer
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
        ],
      );
  //bottom nav to change location
  Widget _changeLocation(BuildContext context) => SafeArea(
          child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => LocationScreen());
            Config.adtype == "facebook"
                ? FacebookInterstitialAd.showInterstitialAd()
                : AdHelper.showInterstitialAd(onComplete: () async {});
          },
          child: Container(
              color: Theme.of(context).bottomNav,
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              height: 60,
              child: Row(
                children: [
                  //icon
                  Icon(CupertinoIcons.globe, color: Colors.white, size: 28),

                  //for adding some space
                  SizedBox(width: 10),

                  //text
                  Text(
                    'Change Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),

                  //for covering available spacing
                  Spacer(),

                  //icon
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.keyboard_arrow_right_rounded,
                        color: HexColor("041c32"), size: 26),
                  )
                ],
              )),
        ),
      ));
}
