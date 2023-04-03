
import 'package:atigindanhaberver/FirstPage.dart';
import 'package:atigindanhaberver/Helpers/MyInheritor.dart';
import 'package:atigindanhaberver/NotificationsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GiverHomePage extends StatefulWidget {
  final user_map;   final user_id;   final user_ref;
  const GiverHomePage({super.key, required this.user_map, required this.user_id, required this.user_ref});

  @override
  State<StatefulWidget> createState() {
    return GiverHomePageState(user_map, user_id, user_ref);
  }

}

class GiverHomePageState extends State<GiverHomePage>{
  final user_map;   final user_id;   final user_ref;
  GiverHomePageState(this.user_map, this.user_id, this.user_ref);

  List <bool> giverThirdTile_boolList = [];
  int thirdTileCounter = 0;
  final formKey = GlobalKey<FormState>();
  TextEditingController weighter = TextEditingController();

  ValueNotifier<bool> atigimiHaberVer = ValueNotifier<bool>(false);

  ValueNotifier<bool> giverFirstTile = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverSecondTile = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverThirdTile = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverFourthTile = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverFifthTile = ValueNotifier<bool>(false);

  ValueNotifier<bool> giverPaperWaste = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverGlassWaste = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverPlasticWaste = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverMetalWaste = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverElectronicWaste = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverPackWaste = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverOtherWaste = ValueNotifier<bool>(false);
  ValueNotifier<int> giverPaperWeight = ValueNotifier<int>(0);
  ValueNotifier<int> giverGlassWeight = ValueNotifier<int>(0);
  ValueNotifier<int> giverPlasticWeight = ValueNotifier<int>(0);
  ValueNotifier<int> giverMetalWeight = ValueNotifier<int>(0);
  ValueNotifier<int> giverElectronicWeight = ValueNotifier<int>(0);
  ValueNotifier<int> giverPackWeight = ValueNotifier<int>(0);
  ValueNotifier<int> giverOtherWeight = ValueNotifier<int>(0);
  ValueNotifier<bool> giverAdress0 = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverAdress1 = ValueNotifier<bool>(false);
  ValueNotifier<bool> giverAdress2 = ValueNotifier<bool>(false);

  List<String> fullAdresses_title = ["Adres0", "Adres1", "Adres2"];

  @override
  Widget build(BuildContext context) {

    List<String> fullAdresses_subtitle = [user_map["fullAdress0"], user_map["fullAdress1"], user_map["fullAdress2"]];
    List<String> cities = [user_map["city0"], user_map["city1"], user_map["city2"]];
    List<String> towns = [user_map["town0"], user_map["town1"], user_map["town2"]];
    List<String> disricts = [user_map["giverDistricts0"], user_map["giverDistricts1"], user_map["giverDistricts2"]];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, backgroundColor: Colors.amber.shade800,
        title: Center(child: Text("${MyInheritor.of(context)?.userName} Atığından Haber Ver")),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              logOut();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only( top: 20.0, bottom: 20),
            child: Column(
              children: [
                TextButton.icon(
                  icon: Icon(Icons.notification_important,
                      size: user_map["notificationsUnseen"] == 0 ? 20: 30,
                      color: user_map["notificationsUnseen"] == 0 ? Colors.blueGrey: Colors.orange
                  ),
                  label: Text("Bildirimler",
                      style: TextStyle( fontWeight: FontWeight.bold,
                          color: user_map["notificationsUnseen"] == 0 ? Colors.blueGrey: Colors.orange,
                          fontSize: user_map["notificationsUnseen"] == 0 ? 15: 20,
                          decoration: TextDecoration.underline)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationsPage(
                      user_map: user_map, user_id: user_id, user_ref: user_ref
                    )));
                  },
                ),
                Visibility( visible: user_map["notificationsUnseen"] == 0 ? false : true,
                  child: const Text("* Okunmamış bildirimleriniz bulunmaktadır!", textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
          const Text("Geri Dönüştürülebilir Atıklar konusunda rehberliğe ihtiyacınız olduğunu düşünüyorsanız Eğitim "
              "butonuna tıklayarak *Eğitim* sayfasını ziyaret edebilirsiniz.",
            style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Container(width: 50, height: 50,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  heroTag: "egitim", backgroundColor: Colors.indigo, elevation: 10,
                  label: Text("Eğitim"), icon: Icon(Icons.book, size: 30, color: Colors.white,),
                  onPressed: () {
                    atigimiHaberVer.value = false;

//*******EĞİTİM SAYFASI YAPILACAK****************
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Bağlı bulunduğunuz atık toplama kurumu "
                "${user_map["takerOrg"].toString().toUpperCase()}dir.",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Atıklarınızı teslim etmek istiyorsanız *Atığımı Haber Ver* butonuna tıklayınız.",
              style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Container(width: 50, height: 50,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  heroTag: "atıgımıHaberVer", backgroundColor: Colors.green, elevation: 10,
                  label: const Text("Atığımı Haber Ver", style: TextStyle(fontWeight: FontWeight.bold),),
                  icon: const Icon(Icons.recycling, size: 30, color: Colors.white,),
                  onPressed: () {
                    atigimiHaberVer.value = true;
                  },
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: atigimiHaberVer,
            builder: (conttext, value, child){
              return Visibility( visible: atigimiHaberVer.value == true ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10, color: Colors.lightGreen.shade100,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Lütfen listedeki tüm alanlardan uygun olanları işaretleyin. Boş alan bırakılamaz.",
                            style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const Divider( color: Colors.indigo, thickness: 3, indent: 10, endIndent: 10,),
                        ListTile(
                          title: const Text("Geri Dönüştürülebilir Atıklarımı çöplerden ayırdım."),
                          onTap: (){
                            giverFirstTileDialog();
                          },
                          trailing: ValueListenableBuilder(
                            valueListenable: giverFirstTile,
                            builder: (context, value, child){
                              return IconButton(
                                  onPressed: (){
                                    giverFirstTile.value = !giverFirstTile.value;
                                  },
                                  icon: Icon(
                                      giverFirstTile.value == false ? Icons.check_box_outline_blank : Icons.check_box
                                  )
                              );
                            },
                          ),
                        ),
                        const Divider( color: Colors.indigo, thickness: 3, indent: 10, endIndent: 10,),

                        ListTile(
                          title: const Text("Geri Dönüştürülebilir Atıklarımı gruplandırdım."),
                          onTap: (){
                            giverSecondTileDialog();
                          },
                          trailing: ValueListenableBuilder(
                            valueListenable: giverSecondTile,
                            builder: (context, value, child){
                              return IconButton(
                                  onPressed: (){
                                    giverSecondTile.value = !giverSecondTile.value;
                                  },
                                  icon: Icon(
                                      giverSecondTile.value == false ? Icons.check_box_outline_blank : Icons.check_box
                                  )
                              );
                            },
                          ),
                        ),
                        const Divider( color: Colors.indigo, thickness: 3, indent: 10, endIndent: 10,),

                        ListTile(
                          title: const Text("Vereceğiniz atıkların grup/gruplarını seçin. "),
                          subtitle: Wrap(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: giverPaperWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("KAĞIT",
                                        style: TextStyle(
                                            fontWeight: giverPaperWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverPaperWaste.value == true ? 18 : 14,
                                            color: giverPaperWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: (){
                                        thirdTileCounter = 1;
                                        giverPaperWaste.value = !giverPaperWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverPaperWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: giverGlassWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("CAM",
                                        style: TextStyle(
                                            fontWeight: giverGlassWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverGlassWaste.value == true ? 18 : 14,
                                            color: giverGlassWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: () {
                                        thirdTileCounter = 2;
                                        giverGlassWaste.value = !giverGlassWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverGlassWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: giverPlasticWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("PLASTİK",
                                        style: TextStyle(
                                            fontWeight: giverPlasticWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverPlasticWaste.value == true ? 18 : 14,
                                            color: giverPlasticWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: (){
                                        thirdTileCounter = 3;
                                        giverPlasticWaste.value = !giverPlasticWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverPlasticWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: giverMetalWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("METAL",
                                        style: TextStyle(
                                            fontWeight: giverMetalWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverMetalWaste.value == true ? 18 : 14,
                                            color: giverMetalWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: () {
                                        thirdTileCounter = 4;
                                        giverMetalWaste.value = !giverMetalWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverMetalWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: giverElectronicWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("ELEKTRONİK",
                                        style: TextStyle(
                                            fontWeight: giverElectronicWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverElectronicWaste.value == true ? 18 : 14,
                                            color: giverElectronicWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: () {
                                        thirdTileCounter = 5;
                                        giverElectronicWaste.value = !giverElectronicWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverElectronicWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: giverPackWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("AMBALAJ",
                                        style: TextStyle(
                                            fontWeight: giverPackWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverPackWaste.value == true ? 18 : 14,
                                            color: giverPackWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: () {
                                        thirdTileCounter = 6;
                                        giverPackWaste.value = !giverPackWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverPackWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: giverOtherWaste,
                                  builder: (context, value, child) {
                                    return TextButton(
                                      child: Text("DİĞER",
                                        style: TextStyle(
                                            fontWeight: giverOtherWaste.value == true ? FontWeight.bold : FontWeight.normal,
                                            fontSize: giverOtherWaste.value == true ? 18 : 14,
                                            color: giverOtherWaste.value == true ? Colors.blue.shade800 : Colors.black
                                        ),),
                                      onPressed: () {
                                        thirdTileCounter = 7;
                                        giverOtherWaste.value = !giverOtherWaste.value;

                                        _thirdTileBoolLister();
                                        if (giverOtherWaste.value == true) {
                                          writeWeight();
                                        }
                                      },
                                    );
                                  }
                              ),
                            ],
                          ),
                          trailing: ValueListenableBuilder(
                            valueListenable: giverThirdTile,
                            builder: (context, value, child){
                              return Icon(
                                  giverThirdTile.value == true ? Icons.check_box : Icons.check_box_outline_blank
                              );
                            },
                          ),
                        ),
                        const Divider( color: Colors.indigo, thickness: 3, indent: 10, endIndent: 10,),

                        ListTile(
                          title: const Text("Ağırlıkları yandaki kutucuğu işaretleyerek onaylayın. Değiştirmek "
                              "yada çıkarmak için üstteki ilgili alana yeniden tıklamanız yeterlidir."),
                          subtitle: Wrap(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverPaperWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverPaperWeight.value == 0 ? false : true,
                                      child: Text("Kağıt ${giverPaperWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverGlassWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverGlassWeight.value == 0 ? false : true,
                                      child: Text("Cam ${giverGlassWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverPlasticWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverPlasticWeight.value == 0 ? false : true,
                                      child: Text("Plastik ${giverPlasticWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverMetalWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverMetalWeight.value == 0 ? false : true,
                                      child: Text("Metal ${giverMetalWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverElectronicWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverElectronicWeight.value == 0 ? false : true,
                                      child: Text("Elektronik ${giverElectronicWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverPackWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverPackWeight.value == 0 ? false : true,
                                      child: Text("Ambalaj ${giverPackWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: giverOtherWeight,
                                  builder: (context, value, child){
                                    return Visibility( visible: giverOtherWeight.value == 0 ? false : true,
                                      child: Text("Diğer ${giverOtherWeight.value} kg",
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17,
                                            decoration: TextDecoration.underline, decorationThickness: 3),),
                                    );
                                  },
                                ),
                              ),

                            ],
                          ),
                          trailing: ValueListenableBuilder(
                            valueListenable: giverFourthTile,
                            builder: (context, value, child){
                              return IconButton(
                                  onPressed: (){
                                    if (giverThirdTile.value == true){
                                      giverFourthTile.value = !giverFourthTile.value;
                                    } else {
                                      AlertDialog alertDialog = const AlertDialog(
                                        title: Text("Hiç grup seçmediniz."),
                                      ); showDialog(context: context, builder: (_) => alertDialog);
                                    }
                                  },
                                  icon: Icon(
                                    giverFourthTile.value == false ? Icons.check_box_outline_blank : Icons.check_box
                                  )
                              );
                            },
                          ),
                        ),
                        const Divider( color: Colors.indigo, thickness: 3, indent: 10, endIndent: 10,),

                        ListTile(
                          title: const Text("Atıklarınızı teslim edeceğiniz adresinizi seçin."),
                          subtitle:Container(
                            height: fullAdresses_title.length == 1 ? 100 : 200,
                            child: ListView(
                              children: [

                                ListTile(
                                  title: Text(fullAdresses_title[0], style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text(fullAdresses_subtitle[0]),
                                  trailing: ValueListenableBuilder(
                                    valueListenable: giverAdress0,
                                    builder: (context, value, child){
                                      return IconButton(
                                          onPressed: (){
                                            giverAdress0.value = true;
                                            giverAdress1.value = false;
                                            giverAdress2.value = false;
                                            giverFifthTile.value = true;
                                          },
                                          icon: Icon(
                                            giverAdress0.value == false ? Icons.circle_outlined : Icons.circle
                                          )
                                      );
                                    },
                                  ),
                                ),
                                const Divider( color: Colors.black, thickness: 2, indent: 5, endIndent: 5,),
                                Visibility( visible: fullAdresses_title[1] == "" ? false : true,
                                  child: ListTile(
                                    title: Text(fullAdresses_title[1], style: TextStyle(fontWeight: FontWeight.bold),),
                                    subtitle: Text(fullAdresses_subtitle[1]),
                                    trailing:  ValueListenableBuilder(
                                      valueListenable: giverAdress1,
                                      builder: (context, value, child){
                                        return IconButton(
                                            onPressed: (){
                                              justAdress0Alert();
/*
                                              giverAdress0.value = false;
                                              giverAdress1.value = true;
                                              giverAdress2.value = false;
                                              giverFifthTile.value = true;
*/
                                            },
                                            icon: const Icon(
                                                Icons.circle_outlined
/*
                                              giverAdress1.value == false ? Icons.circle_outlined : Icons.circle
*/
                                            )
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Visibility( visible: fullAdresses_title[1] == "" ? false : true,
                                    child: const Divider( color: Colors.black, thickness: 2, indent: 5, endIndent: 5,)),
                                Visibility( visible: fullAdresses_title[2] == "" ? false : true,
                                  child: ListTile(
                                    title: Text(fullAdresses_title[2],  style: TextStyle(fontWeight: FontWeight.bold),),
                                    subtitle: Text(fullAdresses_subtitle[2]),
                                    trailing:  ValueListenableBuilder(
                                      valueListenable: giverAdress2,
                                      builder: (context, value, child){
                                        return IconButton(
                                            onPressed: (){
                                              justAdress0Alert();
/*
                                              giverAdress0.value = false;
                                              giverAdress1.value = false;
                                              giverAdress2.value = true;
                                              giverFifthTile.value = true;
*/
                                            },
                                            icon: const Icon(
                                              Icons.circle_outlined
/*
                                              giverAdress2.value == false ? Icons.circle_outlined : Icons.circle
*/
                                            )
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Visibility( visible: fullAdresses_title[2] == "" ? false : true,
                                    child: const Divider( color: Colors.black, thickness: 2, indent: 5, endIndent: 5,)),
                              ],
                            ),
                          ),

                          trailing: ValueListenableBuilder(
                            valueListenable: giverFifthTile,
                            builder: (context, value, child){
                              return Icon(
                                  giverFifthTile.value == true ? Icons.check_box : Icons.check_box_outline_blank
                              );
                            },
                          ),
                        ),
                        const Divider( color: Colors.indigo, thickness: 3, indent: 10, endIndent: 10,),

                        FloatingActionButton.extended(
                          backgroundColor: Colors.green,
                          heroTag: "notify",
                          icon: const Icon(Icons.send),
                          label: const Text("Haber Ver",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                          onPressed: () {
                           notify(fullAdresses_subtitle, cities, towns, disricts);
                          },
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20,),
        ],
      ),
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

  void giverFirstTileDialog() {

    Widget giverFirstTileWidget() {
      return Container(
        child: Column(
          children: const [
            Center(
              child: Text("Geri Dönüştürülemeyen Atıklar (ÇÖPLER) kısaca tek kullanımlık ürünler, besin atıkları ve "
                  "besin-yağ bulaşmış atıklar, dışkılar ve dışkı içeren ürünler ve içerisinde çok çeşitli farklı "
                  "hammadde ve kimyasal içeren ürünler olarak akılda tutulabilir.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Card( elevation: 5,
              child: ListTile(
                title: Text("Tek kullanımlık ürünler: "),
                subtitle: Text("Islak Mendil, Bebek Bezi, Kağıt Havlu, Tuvalet Kağıdı, Yağlı Kağıt, Islak Kağıt,"
                    "Besin Artığı Bulaşmış Kağıt, Kağıt Bardak, Pipet, Köpük,"),
              ),
            ),
            Card( elevation: 5,
              child: ListTile(
                title: Text("Geri Dönüşümü Olmayan Plastikler: "),
                subtitle: Text("Plastik pipetler, farklı türden maddeler içeren oyuncaklar, Yapışkan bant, Naylon, "
                    "streç film,"),
              ),
            ),
            Card( elevation: 5,
              child: ListTile(
                title: Text("Geri Dönüşümü Olmayan Camlar: "),
                subtitle: Text("Pencere camı, bardak camı, seramik ve porselen ürünler, lamba ve florasanlar"),
              ),
            ),
            Card( elevation: 5,
              child: ListTile(
                title: Text("Geri Dönüşümü Olmayan Diğer ürünler: "),
                subtitle: Text("Meyve suyu, süt kutuları, sigara paket ve jelatinler, izmaritler"),
              ),
            ),
          ],
        ),
      );

    }

    AlertDialog alertDialog = AlertDialog(
      title: const Center(
        child: Text("Geri Dönüştürülebilir atıklar çöp değildir. Tekrar ürün imalatında kullanılan hammaddelerdir. "
            "Geri dönüşümü olmayan çöpler, geri dönüştürülebilir atıkların kalitesini bozmaktadır. Bu sebeple "
            "teslim edeceğiniz atıklarınızın çöp bulundurmadığına dikkat ediniz.",
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.indigo, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      content: giverFirstTileWidget(),
    ); showDialog(context: context, builder: (_) => alertDialog);
  }

  void giverSecondTileDialog() {

    AlertDialog alertDialog = const AlertDialog(
      title: Center(
        child: Text("Geri Dönüştürülebilir atıklarını çöplerden ayırmanız sağlıklı geri dönüşüm için yeterli değildir. "
            "Bunları kendi içerisinde de gruplandırmanız gerekir. Atıklarınızı lütfen aşağıda belirtilen başlıklar "
            "altında gruplandırın.",
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.indigo, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text("KAĞIT, CAM, PLASTİK, METAL, ELEKTRONİK, AMBALAJ, DİĞER"),
    ); showDialog(context: context, builder: (_) => alertDialog);
  }

  void _thirdTileBoolLister() {

    if (thirdTileCounter == 1) {
      if (giverPaperWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverPaperWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    } else if (thirdTileCounter == 2) {
      if (giverGlassWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverGlassWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    } else if (thirdTileCounter == 3) {
      if (giverPlasticWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverPlasticWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    } else if (thirdTileCounter == 4) {
      if (giverMetalWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverMetalWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    } else if (thirdTileCounter == 5) {
      if (giverElectronicWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverElectronicWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    } else if (thirdTileCounter == 6) {
      if (giverPackWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverPackWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    } else if (thirdTileCounter == 7) {
      if (giverOtherWaste.value == true) {
        giverThirdTile_boolList.add(true);
      } else {
        giverOtherWeight.value = 0;
        giverThirdTile_boolList.remove(true);
      }
    }

    giverThirdTile_boolList.isEmpty ? giverThirdTile.value = false
        : giverThirdTile.value = true;

    if (giverThirdTile.value == false){
      giverFourthTile.value = false;
    }

  }

  void writeWeight() {

    AlertDialog alertDialog = AlertDialog(
      title: const Text("Tahmini ağırlığı giriniz: "),
      content: Wrap( direction: Axis.horizontal, spacing: 20,
        children: [
          Container( width: 120,
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: weighter,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: thirdTileCounter == 1 ? "Kağıt"
                      : thirdTileCounter == 2 ? "Cam"
                      : thirdTileCounter == 3 ? "Plastik"
                      : thirdTileCounter == 4 ? "Metal"
                      : thirdTileCounter == 5 ? "Elektronik"
                      : thirdTileCounter == 6 ? "Ambalaj"
                      : thirdTileCounter == 7 ? "Diğer"
                      : null,
                  labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.purple),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple)),
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return "ağırlık giriniz";
                  } else { return null; }
                },
              ),
            ),
          ),
          const Text("kg"),
        ],
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: thirdTileCounter == 1 ? giverPaperWeight
            : thirdTileCounter == 2 ? giverGlassWeight
            : thirdTileCounter == 3 ? giverPlasticWeight
            : thirdTileCounter == 4 ? giverMetalWeight
            : thirdTileCounter == 5 ? giverElectronicWeight
            : thirdTileCounter == 6 ? giverPackWeight
            : giverOtherWeight,
          builder: (context, value, child){
            return ElevatedButton(
              child: const Text("Onayla"),
              onPressed: (){
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  int weight_int = int.parse(weighter.text.toString());

                  thirdTileCounter == 1 ? giverPaperWeight.value = weight_int :
                  thirdTileCounter == 2 ? giverGlassWeight.value = weight_int :
                  thirdTileCounter == 3 ? giverPlasticWeight.value = weight_int :
                  thirdTileCounter == 4 ? giverMetalWeight.value = weight_int :
                  thirdTileCounter == 5 ? giverElectronicWeight.value = weight_int :
                  thirdTileCounter == 6 ? giverPackWeight.value = weight_int :
                  thirdTileCounter == 7 ? giverOtherWeight.value = weight_int
                      : null ;


                  Navigator.of(context, rootNavigator: true).pop("dialog");
                }

              },
            );
          },
        ),
      ],
    ); showDialog(
        barrierDismissible: false,
        context: context, builder: (_) => alertDialog
    );
  }


//*************ATIK VEREN GÖNDERİLEN BİLDİRİMİ VERİ TABANINA KAYDETME BAŞLANGIÇ************************

  void notify(List<String> fullAdresses_subtitle, List<String> cities, List<String> towns, List<String> disricts) async {

    if (giverFirstTile.value == true && giverSecondTile.value == true
        && giverThirdTile.value == true && giverFourthTile.value == true && giverFifthTile.value == true ){

      int dayTotalWeight = giverPaperWeight.value + giverGlassWeight.value + giverPlasticWeight.value +
          giverMetalWeight.value + giverElectronicWeight.value + giverPackWeight.value + giverOtherWeight.value;

//*******firebase verici kullalnıcı bildirimi kayıt başlangıç*********************
      await FirebaseFirestore.instance.collection("giverUsers").doc(user_id).get().then((doc) {
        DocumentReference doc_ref = doc.reference;
        doc_ref.update({
          "totalWeights_allTimes": doc.get("totalWeights_allTimes") + dayTotalWeight,
          "totalWeights_unAnswered": doc.get("totalWeights_unAnswered") + dayTotalWeight,
          "lastNotifyDate": DateTime.now(),
          "lastNotifyDate_S": DateTime.now().toString(),
        });

        doc_ref.collection("sentNotifications").add({
          "paper": giverPaperWeight.value, "glass": giverGlassWeight.value, "plastic": giverPlasticWeight.value,
          "metal": giverMetalWeight.value, "electronic": giverElectronicWeight.value, "pack": giverPackWeight.value,
          "other": giverOtherWeight.value, "dayTotalWeight" : dayTotalWeight, "sentNotificationDate": DateTime.now(),
          "adresSent": fullAdresses_subtitle[0], "citySent": cities[0], "townSent": towns[0],
          "districtSent":disricts[0], "sentNotificationDate_S": DateTime.now().toString(),
        });
      });
      
      await FirebaseFirestore.instance.collection("takerUsers").where("city0", isEqualTo: user_map["city0"])
          .where("town0", isEqualTo: user_map["town0"]).get().then((orgs) => orgs.docs.forEach((org) {
            DocumentReference org_ref = org.reference;
            dynamic org_map = org.data();
            dynamic org_id = org.id;
            List <dynamic> districtsToTakeWaste = org_map["districtsToTakeWaste"];
            org_ref.collection("takenNotifications").add({
              "answerDate": null, "answerDate_S": "", "city": cities[0], "dayTotalWeight" : dayTotalWeight,
              "town": towns[0], "district": disricts[0], "giverfullAdress": user_map["fullAdress0"],
              "isAnswered": false, "isRead": false, "isTaken": false,
              "dateToTake_S": "", "giverName": MyInheritor.of(context)?.userName,
              "giverMail": MyInheritor.of(context)?.userMail, "giverUid": MyInheritor.of(context)?.uid,
              "paperWeight": giverPaperWeight.value, "glassWeight": giverGlassWeight.value,
              "plasticWeight": giverPlasticWeight.value, "metalWeight": giverMetalWeight.value,
              "electronicWeight": giverElectronicWeight.value, "packWeight": giverPackWeight.value,
              "otherWeight": giverOtherWeight.value,
            });
            if (!districtsToTakeWaste.contains(disricts[0])){
              districtsToTakeWaste.add(disricts[0]);
              print(districtsToTakeWaste);
            }
            org_ref.update({
              "districtsToTakeWaste" : districtsToTakeWaste,
              "takenNotificationCount" : org_map["takenNotificationCount"] + 1,
              "paperWeights_unAnswered" : org_map["paperWeights_unAnswered"] + giverPaperWeight.value,
              "glassWeights_unAnswered" : org_map["glassWeights_unAnswered"] + giverGlassWeight.value,
              "plasticWeights_unAnswered" : org_map["plasticWeights_unAnswered"] + giverPlasticWeight.value,
              "metalWeights_unAnswered" : org_map["metalWeights_unAnswered"] + giverMetalWeight.value,
              "electronicWeights_unAnswered" : org_map["electronicWeights_unAnswered"] +
                  giverElectronicWeight.value,
              "packWeights_unAnswered" : org_map["packWeights_unAnswered"] + giverPackWeight.value,
              "otherWeights_unAnswered" : org_map["otherWeights_unAnswered"] + giverOtherWeight.value,
              "totalWeights_unAnswered" : org_map["totalWeights_unAnswered"] + dayTotalWeight,
            });
      }));

//*******firebase verici kullalnıcı bildirimi kayıt bitiş*********************

      AlertDialog alertDialog = AlertDialog(
        title: const Center(
          child: Text("Atığınız başarıyla ilgili kuruma gönderildi. Bildirimlerinizi takip ederek "
              "atık alımı ile ilgili duyurulara ulaşabilirsiniz." ,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),),
        ),
        actions: [
          ElevatedButton(
            child: Text("Tamam"),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  GiverHomePage(user_map: user_map, user_id: user_id, user_ref: user_ref,)));
            },
          ),
        ],
      ); showDialog( barrierDismissible: false,
          context: context, builder: (_) => alertDialog);
    } else {
      AlertDialog alertDialog = const AlertDialog(
        title: Center(
          child: Text("İşaretlemediğiniz alanlar görülmektedir. Lütfen kontrol ediniz veya daha sonra "
              "tekrar deneyiniz." ,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),),
        ),
      ); showDialog(context: context, builder: (_) => alertDialog);
    }

  }
//*************ATIK VEREN GÖNDERİLEN BİLDİRİMİ VERİ TABANINA KAYDETME BİTİŞ************************

  void justAdress0Alert() {
    AlertDialog alertDialog = const AlertDialog(
      title: Text("Şimdilik sadece tek adres seçimi aktiftir. Diğer adresler için "
          "güncellemeleri bekleyiniz."),
    ); showDialog(context: context, builder: (_) => alertDialog);
  }

}



