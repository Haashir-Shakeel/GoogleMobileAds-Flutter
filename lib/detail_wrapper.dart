import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class DetailWrapper extends StatefulWidget {
  final List<Map<String, dynamic>> Sunlist;
  DetailWrapper({required this.Sunlist});

  @override
  State<DetailWrapper> createState() => _DetailWrapperState();
}

class _DetailWrapperState extends State<DetailWrapper> {

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/1033173712";

  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: adUnit,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad){
              interstitialAd = ad;
              setState(() {
                isAdLoaded = true;
              });
              interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad){
                  ad.dispose();
                  //add code here
                  setState(() {
                    isAdLoaded = false;
                  });
                  print('AD IS DISMISSED');
                },
                onAdFailedToShowFullScreenContent: (ad, error){
                  ad.dispose();
                  setState(() {
                    isAdLoaded = false;
                  });
                  print('AD IS DISMISSED');
              }
              );
            },
            onAdFailedToLoad: ((error){
              interstitialAd.dispose();
            })
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('AdPage'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            if (isAdLoaded){
              interstitialAd.show();
            } else{
              Navigator.pop(context);
            }
          },
        ),
        ),
        body: SingleChildScrollView(
          child: Column(

            children: [

            Container(height: MediaQuery.of(context).size.height*0.2,
            color: Colors.red,
            ),
            ElevatedButton(
            onPressed: (){
              if(isAdLoaded){
                interstitialAd.show();
              }
            },
            child: Center(child: Text('button'),))
            ],


          ),
        ),
    );
  }
}
