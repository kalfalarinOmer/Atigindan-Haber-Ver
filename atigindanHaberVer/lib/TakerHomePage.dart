// * notify ile kurum alma bildirimi gönderdiğinde ilgili mahallenin toplam ağırlığı
// * ve türlerine göre ağırlıkları 0 olacak. Fakat gelen bildirimlerden türlerin toplam
// * ağırlıkları sıfırlanmadan mahalleye ait ağırlıklar eksiltilecek.
// * TotalWeigths_unAnswered tan eksiltme yapılacak.
// * taken notifications dan answer date güncellenecek, isAnswered true yapılacak.
// * toplayan kurumda sentNotifications koleksiyonuna gönderilmiş bildirim olarak eklenecek.
// * ilgili mahalle sakinine alınmış bildirim olarak kaydedilecek.
// * giver sentNotifications da gerekli güncellemeler yapılacak.

import 'package:atigindanhaberver/FirstPage.dart';
import 'package:atigindanhaberver/Helpers/MyInheritor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TakerHomePage extends StatefulWidget{
  final user_map;   final user_id;   final user_ref;
  const TakerHomePage({super.key, required this.user_map, required this.user_id, required this.user_ref});

  @override
  State<StatefulWidget> createState() {
    return TakerHomePageState(user_map, user_id, user_ref);
  }

}

class TakerHomePageState extends State<TakerHomePage>{
  final user_map;   final user_id;   final user_ref;
  TakerHomePageState(this.user_map, this.user_id, this.user_ref);

  List<int> districts_weights = [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 100, 100, 100, 100, 100, 100,
    30, 30, 30, 30, 30, 30, ];

  List<String> kindsOfWastes = ["kağıt", "cam", "plastik", "metal", "elektronik", "ambalaj", "diğer"];
  List<int> weightsOfkinds = [];
  List<String> districtsToTakeWaste = [];
  List<String> dates = [];
  List<String> times = [];
  List<String> points = [];
  List<String> districts = [];

  int indexFromWasteTakingToNotify = 0;

  final formKey = GlobalKey<FormState>();
  TextEditingController dater = TextEditingController();
  TextEditingController timer = TextEditingController();
  TextEditingController pointer = TextEditingController();

  ValueNotifier<bool> takerFourthCard = ValueNotifier<bool>(false);

  int totalWasteCount = 0;

  @override

  Widget build(BuildContext context) {

    weightsOfkinds = [user_map["paperWeights_unAnswered"], user_map["glassWeights_unAnswered"],
      user_map["plasticWeights_unAnswered"], user_map["metalWeights_unAnswered"], user_map["electronicWeights_unAnswered"],
      user_map["packWeights_unAnswered"], user_map["otherWeights_unAnswered"], ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, backgroundColor: Colors.amber.shade800,
        title: const Center(child: Text("Atıkları Topla")),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              logOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("* Henüz cevaplamamış atık toplama taleplerine ait bilgiler listelenmiştir. Atık "
                  "toplama tarih ve saat mahalleye haber verildiğinde talepler cevaplandırılmış sayılır ve "
                  "tüm bilgiler sıfırlanır.", textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("** Talepleri cevaplama ile atıkların toplanması işleminin aynı gün içerisinde yapılması"
                  " önerilmektedir.", textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("*** 4. alandaki mahallelere tıklayarak mahalle için atık toplama bilgilerinizi"
                  " girebilirsiniz.", textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
              ),
            ),
            Card( elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.looks_one_outlined, size: 30, color: Colors.green,),
                title: const Text("Bildirilen atık toplama talep sayısı:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                subtitle: Text(user_map["takenNotificationCount"].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 20, fontStyle: FontStyle.italic, decoration: TextDecoration.underline,
                    color: Colors.indigo),),
                tileColor: Colors.blue.shade100,
              ),
            ),
            const SizedBox(height: 20,),
            Card( elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.looks_two_outlined, size: 30, color: Colors.green,),
                title: const Text("Bildirilen toplam atık ağırlığı (kg):",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                subtitle: Text( user_map["totalWeights_unAnswered"].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                    fontStyle: FontStyle.italic, decoration: TextDecoration.underline, color: Colors.indigo),),
                tileColor: Colors.blue.shade100,
              ),
            ),
            const SizedBox(height: 20,),
            Card( elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.looks_3_outlined, size: 30, color: Colors.green,),
                tileColor: Colors.blue.shade100,
                title: const Text("Bildirilen atık türleri ve ağırlıkları:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                subtitle: Container(height: 150,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 5),
                    itemCount: kindsOfWastes.length,
                    itemBuilder: (context, index){
                      return GridTile(
                        child: Text("${kindsOfWastes[index]}: ${weightsOfkinds[index].toString()} kg" ,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: weightsOfkinds[index] == 0 ? 15 : 18,
                              fontStyle: weightsOfkinds[index] == 0 ? FontStyle.normal : FontStyle.italic,
                              decoration: TextDecoration.underline,
                              color: weightsOfkinds[index] == 0 ? Colors.green
                                  : weightsOfkinds[index] >= 50 ? Colors.red : Colors.amber.shade800,
                              backgroundColor: weightsOfkinds[index] == 0 ? Colors.transparent : Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Card( elevation: 10,
              child: ListTile(
                leading: const Icon(Icons.looks_4_outlined, size: 30, color: Colors.green,),
                tileColor: Colors.blue.shade100,
                title: const Text("Mahallelere göre atık ağırlıkları:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                subtitle: Column(
                  children: [
                    const Text("Mahallenin üzerine tıklayarak atık toplama tarihi, saat aralığı ve noktasını giriniz."),
                    const SizedBox(height: 10,),
                    SizedBox(height: 150,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2),
                        itemCount: user_map["districtsToTakeWaste"].length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            child: GridTile(
                              footer: Divider(thickness: 3,),
                              child: Text("${user_map["districtsToTakeWaste"][index]}: "
                                  "${districts_weights[index].toString()} kg" ,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                                    fontStyle: FontStyle.italic, decoration: TextDecoration.underline,
                                    color: districts_weights[index] >= 50 ? Colors.red : Colors.amber.shade800,
                                    backgroundColor: Colors.white),
                              ),
                            ),
                            onTap: (){
                              wasteTakingTime(index);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Visibility( visible: districtsToTakeWaste.isEmpty ? false : true,
              child: Card( elevation: 10,
                child: ListTile(
                  leading: const Icon(Icons.looks_5_outlined, size: 30, color: Colors.green,),
                  tileColor: Colors.blue.shade100,
                  title: const Text("Mahalleler için girilen atık toplama tarih, saat ve noktalarının doğru olduğunu "
                      "yandaki kutucuğu işaretleyerek onaylayın.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  subtitle: Wrap(
                    children: [
                      const Text("Düzeltme yapmak istediğiniz mahallenin üzerine tıklayınız."),
                      SizedBox(height: 200,
                        child: ListView.builder(
                          itemCount: districtsToTakeWaste.isEmpty ? 0 : districtsToTakeWaste.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                editDistrict(index);
                              },
                              child: Wrap(
                                children: [
                                  const Divider(thickness: 2, color: Colors.grey,),
                                  Text("${districtsToTakeWaste[index]}: " ,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                                        color: Colors.indigo),
                                  ),
                                  Text("${dates[index].toString()} tarihinde / ${times[index].toString()} arası, " ,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
                                        color: Colors.green.shade800),
                                  ),
                                  Text(points[index],  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 15, color: Colors.green.shade800),),
                                  const Text("  noktasından toplanacaktır."),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: takerFourthCard,
                    builder: (context, value, child){
                      return IconButton(
                          onPressed: (){
                            takerFourthCard.value = !takerFourthCard.value;
                          },
                          icon: Icon(
                            takerFourthCard.value == false ? Icons.check_box_outline_blank : Icons.check_box
                          )
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),

            Container( width: 120,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green,
                heroTag: "notify",
                icon: const Icon(Icons.send),
                label: const Text("Mahalleye Haber Ver",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                onPressed: () {
                  notify();
                },
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();

    MyInheritor.of(context)?.isTaker == null;
    MyInheritor.of(context)?.isGiver == null;
    MyInheritor.of(context)?.userName = null;
    MyInheritor.of(context)?.userMail = null;

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage()));
  }

  void wasteTakingTime(int index) async {
    AlertDialog alertDialog = AlertDialog(
      title: Center(
          child: Text("${user_map["districtsToTakeWaste"][index]} mahallesi için atık toplama Tarih ve "
              "saat aralığı giriniz:", textAlign: TextAlign.center,
          )),
      content: Form(
        key: formKey,
        child: Container( height: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Atık toplama tarihini gün.ay.yıl olarak giriniz.", style: TextStyle(fontSize: 13),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: dater,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Toplama tarihi",
                    labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.purple),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple)),
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "tarih giriniz";
                    } else { return null; }
                  },
                ),
                const Divider(thickness: 3, color: Colors.indigo,),
                SizedBox(height: 5,),
                const Text("Atık toplama saati için girilecek saat aralığı en fazla 1 saat olmalıdır. "
                    "Örneğin 9-10, 11.30-12.00, 13.15-14.00 ... gibi", style: TextStyle(fontSize: 13),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: timer,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Toplama için saat aralığı",
                    labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.purple),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple)),
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "saat aralığı giriniz";
                    } else { return null; }
                  },
                ),
                const Divider(thickness: 3, color: Colors.indigo,),
                SizedBox(height: 5,),
                const Text("Atık toplama noktasını herkesin anlayabileceği şekilde kısaca tarif ediniz. "
                    "Örneğin Y okulunun önü gibi", style: TextStyle(fontSize: 13),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: pointer,
                  decoration: const InputDecoration(
                    labelText: "Atık toplama noktası",
                    labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.purple),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple)),
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "Atık toplama noktası giriniz";
                    } else { return null; }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text("Onayla"),
          onPressed: (){
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();

              String _time = timer.text.trim().toString();
              String _date = dater.text.trim().toString();
              String _point = pointer.text.trim().toString();

              districtsToTakeWaste.add(user_map["districtsToTakeWaste"][index]);
              dates.add(_date);
              times.add(_time);
              points.add(_point);

              takerFourthCard.value = true;

              indexFromWasteTakingToNotify = index;

              setState(() {});

              Navigator.of(context, rootNavigator: true).pop("dialog");
            }

          },
        )
      ],
    ); showDialog(context: context, builder: (_) => alertDialog);
  }

  void editDistrict(int index) async {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Yapmak istediğiniz işlemi seçiniz: "),
      actions: [
        ElevatedButton(
          child: const Text("Mahalleyi listeden kaldır"),
          onPressed: (){
            districtsToTakeWaste.removeAt(index);
            dates.removeAt(index);
            times.removeAt(index);

            if (districtsToTakeWaste.isEmpty){
              takerFourthCard.value = false;
            }

            setState(() {});

            Navigator.of(context, rootNavigator: true).pop("dialog");
          },
        ),
        ElevatedButton(
          child: const Text("Tarih/Saat düzenle"),
          onPressed: (){
            int indexInDistricts =  user_map["districtsToTakeWaste"].indexOf(districtsToTakeWaste[index]);

            districtsToTakeWaste.removeAt(index);
            dates.removeAt(index);
            times.removeAt(index);
            points.removeAt(index);

            wasteTakingTime(indexInDistricts);

          },
        ),
      ],
    ); showDialog(context: context, builder: (_) => alertDialog);

  }

  void notify() async {

    if (takerFourthCard.value == true ){

      await FirebaseFirestore.instance.collection("takerUsers").doc(user_id).get().then((_user) {

        _user.reference.collection("takenNotifications").where("isAnswered", isEqualTo: false)
            .where("district", whereIn: districtsToTakeWaste ).get().then((nots) => nots.docs.forEach((doc) {
          final doc_ref = doc.reference;
          final doc_id  = doc.id;
          final doc_map = doc.data();
          final doc_lenght = doc_map.length;

          doc.reference.update({
            "answerDate" : DateTime.now(), "answerDate_S": DateTime.now().toString(),
            "takenDate_S": dates[indexFromWasteTakingToNotify], "isAnswered" : true,
          });

        }));
      });

      AlertDialog alertDialog = AlertDialog(
        title: const Center(
          child: Text("Mahallere ait atık toplama tarih, saat aralığı ve toplama noktası ilgili mahalle sakinlerine "
              "gönderilmiştir. " ,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Tamam"),
            onPressed: (){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  TakerHomePage(user_map: user_map, user_id: user_id, user_ref: user_ref,)));
            },
          ),
        ],
      ); showDialog(context: context, builder: (_) => alertDialog);
    } else {
      AlertDialog alertDialog = const AlertDialog(
        title: Center(
          child: Text("5. alandaki onay kutusunun işaretlendiğinden emin olunuz veya daha sonra "
              "tekrar deneyiniz." ,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),),
        ),
      ); showDialog(context: context, builder: (_) => alertDialog);
    }

  }
}