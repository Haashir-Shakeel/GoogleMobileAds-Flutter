import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'detail_wrapper.dart';

class Wrapper extends StatefulWidget {
  final List<Map<String, dynamic>> Sunlist;
  Wrapper({required this.Sunlist});

  @override
  State<Wrapper> createState() => _WrapperState();
}



class _WrapperState extends State<Wrapper> {

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit = 'ca-app-pub-3940256099942544/6300978111';

  initBannerAd() {
    print(adUnit);
    bannerAd= BannerAd(
        size: AdSize.banner,
        adUnitId: adUnit,
        listener: BannerAdListener(
          onAdLoaded: (ad){
            setState(() {
              isAdLoaded = true;
            });
          },

          onAdFailedToLoad: (ad,error){
            ad.dispose();
            print(error);
    },
        ),
        request: AdRequest(
          // keywords: <String>['foo', 'bar'],
          // contentUrl: 'http://foo.com/bar.html',
          // nonPersonalizedAds: true,
        ),
    );

    bannerAd.load();
    print(adUnit);
  }


  @override
  void initState() {

    super.initState();
    initBannerAd();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: Text('AdPage'),),
      body: SingleChildScrollView(
        child: Column(

          children: [

            Container(height: MediaQuery.of(context).size.height*0.6,
            color: Colors.red,
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailWrapper(Sunlist: widget.Sunlist),
                  ));
                },
                child: Center(child: Text('button'),))
          ],


        ),
      ),
      bottomNavigationBar: isAdLoaded
      ? SizedBox(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd,),
      ): const SizedBox()
    );

  }
}
