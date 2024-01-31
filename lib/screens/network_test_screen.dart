import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vpn_basic_project/controllers/native_ad_controller.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/helpers/config.dart';

import '../apis/apis.dart';
import '../main.dart';
import '../models/ip_details.dart';
import '../models/network_data.dart';
import '../widgets/network_card.dart';

class NetworkTestScreen extends StatelessWidget {
  NetworkTestScreen({super.key});

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);
    double height = Get.height;
    print("height-----------------------------------------------${height}");
    return Scaffold(
      backgroundColor: HexColor("04293A").withOpacity(0.6),
      appBar: AppBar(title: Text('Network Test Screen')),

      //refresh button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
            backgroundColor: HexColor("064663"),
            onPressed: () {
              ipData.value = IPDetails.fromJson({});
              APIs.getIPDetails(ipData: ipData);
            },
            child: Icon(
              CupertinoIcons.refresh,
              color: Colors.white,
            )),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.6,
              child: Obx(
                () => ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                        left: mq.width * .04,
                        right: mq.width * .04,
                        top: mq.height * .01,
                        bottom: mq.height * .1),
                    children: [
                      //ip
                      NetworkCard(
                          data: NetworkData(
                              title: 'IP Address',
                              subtitle: ipData.value.query,
                              icon: Icon(CupertinoIcons.location_solid,
                                  color: Colors.blue))),

                      //isp
                      NetworkCard(
                          data: NetworkData(
                              title: 'Internet Provider',
                              subtitle: ipData.value.isp,
                              icon:
                                  Icon(Icons.business, color: Colors.orange))),

                      //location
                      NetworkCard(
                          data: NetworkData(
                              title: 'Location',
                              subtitle: ipData.value.country.isEmpty
                                  ? 'Fetching ...'
                                  : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
                              icon: Icon(CupertinoIcons.location,
                                  color: Colors.pink))),

                      //pin code
                      NetworkCard(
                          data: NetworkData(
                              title: 'Pin-code',
                              subtitle: ipData.value.zip,
                              icon: Icon(CupertinoIcons.location_solid,
                                  color: Colors.cyan))),

                      //timezone
                      NetworkCard(
                          data: NetworkData(
                              title: 'Timezone',
                              subtitle: ipData.value.timezone,
                              icon: Icon(CupertinoIcons.time,
                                  color: Colors.green))),
                    ]),
              ),
            ),
            Container(
              child: Config.adtype == "facebook"
                  ? FacebookNativeAd(
                      placementId: Config.fbnative,
                      adType: NativeAdType.NATIVE_AD,
                      width: double.infinity,
                      height: 300,
                      backgroundColor: Colors.blue,
                      titleColor: Colors.white,
                      descriptionColor: Colors.white,
                      buttonColor: Colors.deepPurple,
                      buttonTitleColor: Colors.white,
                      buttonBorderColor: Colors.white,
                      keepAlive:
                          true, //set true if you do not want adview to refresh on widget rebuild
                      keepExpandedWhileLoading:
                          false, // set false if you want to collapse the native ad view when the ad is loading
                      expandAnimationDuraion:
                          300, //in milliseconds. Expands the adview with animation when ad is loaded
                      listener: (result, value) {
                        print("Native Ad: $result --> $value");
                      },
                    )
                  : Config.adtype == "google_ads"
                      ? _adController.ad != null &&
                              _adController.adLoaded.isTrue
                          ? SafeArea(
                              child: SizedBox(
                                  height: 300,
                                  child: AdWidget(ad: _adController.ad!)))
                          : null
                      : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
