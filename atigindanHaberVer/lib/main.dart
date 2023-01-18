// *Atıkların mahallelere göre toplam miktarlarının kaydı ve gösterilmesi yapılacak

// * notify ile kurum alma bildirimi gönderdiğinde ilgili mahallenin toplam ağırlığı
// * ve türlerine göre ağırlıkları 0 olacak. Fakat gelen bildirimlerden türlerin toplam
// * ağırlıkları sıfırlanmadan mahalleye ait ağırlıklar eksiltilecek.
// * TotalWeigths_unAnswered tan eksiltme yapılacak.
// * taken notifications dan answer date güncellenecek, isAnswered true yapılacak.
// * toplayan kurumda sentNotifications koleksiyonuna gönderilmiş bildirim olarak eklenecek.
// * ilgili mahalle sakinine alınmış bildirim olarak kaydedilecek.
// * giver sentNotifications da gerekli güncellemeler yapılacak.

// * bildirim gösterme ekranı yapılacak

import 'package:atigindanhaberver/FirstPage.dart';
import 'package:atigindanhaberver/Helpers/MyInheritor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyInheritor( child: AtigindanHaberVer()));
}

class AtigindanHaberVer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atigindan Haber Ver",
      theme: ThemeData(),
      home: FirstPage(),
    );
  }
}

