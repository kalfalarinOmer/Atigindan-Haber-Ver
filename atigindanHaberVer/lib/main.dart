

import 'package:atigindanhaberver/FirstPage.dart';
import 'package:atigindanhaberver/Helpers/MyInheritor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {                                        //main(): Ana fonksiyondur. Uygulamanın kodlarını çalışmasını başlatır.
  WidgetsFlutterBinding.ensureInitialized();               // FirstPage: ilk karşılama sayfasını
  await Firebase.initializeApp();                          // GiverHomePage: Atık Veren kullanıcı anasayfası
  runApp( MyInheritor( child: AtigindanHaberVer()));       // NotificationsPage: Bildirimler sayfası
}                                                          // RegisterLoginPage: Kayıt/Giriş işlemleri sayfası
                                                           // TakerHomePage: toplayıcı kurum anasayfası
class AtigindanHaberVer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atığından Haber Ver",
      theme: ThemeData(),
      home: FirstPage(),
    );
  }
}

