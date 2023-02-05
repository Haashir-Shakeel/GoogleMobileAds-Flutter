import 'package:admob_practice/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['8C07A346A17C154027F53CEE2D368AFC']));

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()

  ));
}

var ListE = [
  {'name': 'Sun1'},
  {'name': 'Sun2'},
  {'name': 'Sun3'},
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Appbar'),
          ),
          body: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Wrapper(Sunlist: ListE),
              ));
            }, child: Text('Press'),
          )


    );
  }
}
