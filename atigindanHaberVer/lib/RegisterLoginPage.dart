

import 'package:atigindanhaberver/FirstPage.dart';
import 'package:atigindanhaberver/Helpers/MyInheritor.dart';
import 'package:atigindanhaberver/GiverHomePage.dart';
import 'package:atigindanhaberver/TakerHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterLoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return RegisterLoginPageState();
  }
}

class RegisterLoginPageState extends State<RegisterLoginPage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _namer = TextEditingController();
  TextEditingController _mailer = TextEditingController();
  TextEditingController _passworder = TextEditingController();
  TextEditingController _citier = TextEditingController();
  TextEditingController _towner = TextEditingController();
  TextEditingController _districter = TextEditingController();
  TextEditingController _giverAdresser0 = TextEditingController();


  bool isRegister = false;
  bool isLogin = false;
  bool isMunicipality = false;

  String city0 = "";  String town0 = "";  String giverDistricts0 = "";  String giverAdress0 = "";
  String city1 = "";  String town1 = "";  String giverDistricts1 = "";  String giverAdress1 = "";
  String city2 = "";  String town2 = "";  String giverDistricts2 = "";  String giverAdress2 = "";
  List <String> allDistricts = [];
  List <String> districtsToTakeWaste = [];
  String takerOrg = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade800,
        title: Center(child: Text(
          MyInheritor.of(context)?.isGiver == true ?
            "Atık Veren Kayıt/Giriş" : "Atık Toplayan Kayıt/Giriş"
        )),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Form( key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 50,),
//UserName
                Visibility( visible: isRegister == false && isLogin == false ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _namer,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: MyInheritor.of(context)!.isTaker == true ? " Kurum adı" : "Ad Soyad",
                          labelStyle: const TextStyle(color: Colors.purple), border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return MyInheritor.of(context)!.isTaker == true ? "Kurum adı girmelisiniz"
                              : "Ad Soyad girmelisiniz.";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//mail
                Visibility( visible: isRegister == false && isLogin == false ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _mailer,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: MyInheritor.of(context)!.isTaker == true ? "Kurum E-mail Adresi" : "E-mail adresiniz",
                          labelStyle: const TextStyle(color: Colors.purple), border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return "E-mail adresi girmelisiniz";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//password
                Visibility( visible: isRegister == false && isLogin == false ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _passworder,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          labelText: "Şifre",
                          labelStyle: TextStyle(color: Colors.purple), border: OutlineInputBorder(),
                          hintText: "en az 6 karakter girilmelidir ve boşluk kullanmayınız",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                          focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){ return "Şifrenizi girmelisiniz";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//kurum seçin
                Visibility( visible: isRegister == true && MyInheritor.of(context)?.isTaker == true ? true : false,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      child: Text("Kurum Türünü seçiniz:",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
                    ),
                  ),
                ),
//kurumlar
                Visibility( visible: isRegister == true && MyInheritor.of(context)?.isTaker == true ? true : false,
                  child: Center(
                    child: Wrap( spacing: 20,
                      children: [
                        TextButton(
                          child: const Text("Kamu", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
                              decoration: TextDecoration.underline),),
                          onPressed: (){
                            justMunicipalityAlert();
                          },
                        ),
                        TextButton(
                          child: const Text("Belediye",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
                              decoration: TextDecoration.underline),),
                          onPressed: (){
                            setState(() {
                              isMunicipality = true;
                            });
                          },
                        ),
                        TextButton(
                          child: const Text("Vakıf", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
                              decoration: TextDecoration.underline),),
                          onPressed: (){
                            justMunicipalityAlert();
                          },
                        ),
                        TextButton(
                          child: const Text("Özel", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
                              decoration: TextDecoration.underline),),
                          onPressed: (){
                            justMunicipalityAlert();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//Adres girin
                Visibility( visible: isRegister == true && MyInheritor.of(context)?.isGiver == true ? true : false,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      child: Text("Adresinizi giriniz:",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
                    ),
                  ),
                ),
                Visibility( visible: isRegister == true && MyInheritor.of(context)?.isGiver == true ? true : false,
                    child: const SizedBox(height: 30,)),
//city
                Visibility( visible: MyInheritor.of(context)?.isGiver == true
                    ? isRegister == true ? true : false
                    : isMunicipality == true ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _citier,
                      decoration: const InputDecoration(
                          labelText: "Şehir adını giriniz",
                          labelStyle: TextStyle(color: Colors.purple), border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){ return "şehir adını giriniz";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//town
                Visibility( visible: MyInheritor.of(context)?.isGiver == true
                    ? isRegister == true ? true : false
                    : isMunicipality == true ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _towner,
                      decoration: const InputDecoration(
                          labelText: "İlçe adını giriniz",
                          labelStyle: TextStyle(color: Colors.purple), border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){ return "ilçe adını giriniz";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//districts
                Visibility( visible: MyInheritor.of(context)?.isGiver == true
                    ? isRegister == true ? true : false
                    : isMunicipality == true ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _districter,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          labelText: MyInheritor.of(context)?.isTaker == true
                              ? "Tüm Mahalleleri virgülle ayırarak bu alana giriniz."
                              : "Mahallenizin adını giriniz",
                          hintText: "Ata, Osman Yozgatlı, 19 Mayıs, ... gibi",
                          labelStyle: const TextStyle(color: Colors.purple), border: const OutlineInputBorder(),
                          hintStyle: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                          focusedBorder: const OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){ return "Mahallelerin adını giriniz";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
//giverAdress
                Visibility( visible: isRegister == true && MyInheritor.of(context)?.isGiver == true ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _giverAdresser0,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "Adresinizin kalan kısmını sokak, no, aprt. adı, daire(iç kapı) no, ... giriniz",
                          hintText: "32. sokak, No: 3, Gül apartmanı, daire: 5, ... gibi",
                          labelStyle: TextStyle(color: Colors.purple), border: OutlineInputBorder(),
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                          focusedBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.purple))
                      ),
                      validator: (value) {
                        if(value!.isEmpty){ return "Adresinizin kalan kısmını girmelisiniz.";
                        } else { return null; }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,),

                Center(
                  child: Wrap( spacing: 20,
                    children: [
                      FloatingActionButton.extended(
                        backgroundColor: Colors.green,
                        heroTag: "kaydol",
                        icon: const Icon(Icons.add),
                        label: const Text( "KAYDOL",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        onPressed: () async {

                          if (isRegister == false) {
                            setState(() {
                              isRegister = true;
                              isLogin = false;
                            });
                          } else if (isRegister == true) {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              if (MyInheritor.of(context)?.isGiver == true){
                                register();
                              } else if (MyInheritor.of(context)?.isTaker == true){
                                if (isMunicipality == true){
                                  register();
                                } else {
                                  AlertDialog alertDialog = const AlertDialog(
                                    title: Text("Kurum seçmediniz."),
                                  ); showDialog(context: context, builder: (_) => alertDialog);
                                }
                              }
                            }
                          }
                        },
                      ),

                      FloatingActionButton.extended(
                        backgroundColor: Colors.blue,
                        heroTag: "giris",
                        icon: const Icon(Icons.login),
                        label: const Text("GİRİŞ YAP",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            if (isLogin == false) {
                              setState(() {
                                isRegister = false;
                                isLogin = true;
                              });
                            } else if (isLogin == true) {
                              logIn();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),

                Visibility( visible: isLogin == false ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Align( alignment: Alignment.centerRight,
                      child: MaterialButton(
                        child: const Text("Şifremi Sıfırla",
                          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, fontSize: 20),),
                        onPressed: () async {
/*
                          Widget setupAlertDialogContainer() {
                            return Container(
                              height: 200, width: 300,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection("users").where("userName",
                                      isEqualTo: _namer.text.trim()).snapshots(),
                                  builder: (context, snapshot){
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator(),);
                                    } else if (snapshot.hasError) {
                                      return Center(child: Icon(Icons.error, size: 40),);
                                    } else if (snapshot.data == null) {
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    final querySnapshot = snapshot.data;
                                    return Container(
                                      child: querySnapshot.size == 0 ? Center(
                                        child: ListTile(
                                          leading: Icon(Icons.warning, color: Colors.red,),
                                          title: Text( MyInheritor.of(context).langEng != true ?
                                          "Kullanıcı adı bulunamadı. Lütfen forma girdiğiniz kullanıcı adınızı"
                                              "kontrol ediniz."
                                              : "Username can not be found. Please check your username that you typed"
                                              " in the Form.",
                                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,),
                                        ),
                                      ):
                                      ListView.builder(
                                          itemCount: querySnapshot.size,
                                          itemBuilder: (BuildContext context, int index){
                                            final map = querySnapshot.docs[index].data();
                                            final id = querySnapshot.docs[index].id;
                                            return Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(_namer.text.trim(),
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                                    onTap: ()async{
                                                      Navigator.of(context, rootNavigator: true).pop("dialog");

                                                      print(map["userMail"]);
                                                      reset_password(_namer.text.trim(), map, id);

                                                    },),
                                                  Divider(thickness: 1,),]);
                                          }),
                                    );

                                  }),
                            );
                          }
                          showDialog(context: context, builder: (_) {
                            return AlertDialog(
                              title: Column(children: [
                                Text( MyInheritor.of(context).langEng != true ? "ŞİFREMİ SIFIRLA " : "RESET MY PASSWORD"),
                                SizedBox(height: 10,),
                                Text( MyInheritor.of(context).langEng != true ?
                                "Kullanıcı adınıza tıklayarak şifre sıfırlama işleminizi başlatabilirsiniz."
                                    : "You can start your password reset process by clicking on your username.",
                                  style: TextStyle(color: Colors.orange, fontSize: 15, ),),
                              ]),
                              content: setupAlertDialogContainer(),
                            );
                          });

 */
                        },
                      ),
                    ),
                  ),
                ),
              ],)
        ),
      ),
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();

    MyInheritor.of(context)?.isTaker == null;
    MyInheritor.of(context)?.isGiver == null;
    MyInheritor.of(context)?.userName = null;
    MyInheritor.of(context)?.userMail = null;
    MyInheritor.of(context)?.uid = null;

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage()));
  }

  void register() async {

    try {

      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _mailer.text.trim(), password: _passworder.text.trim()
      );
      final User? user = userCredential.user;

      if (user != null){

        MyInheritor.of(context)?.userName = _namer.text.trim();
        MyInheritor.of(context)?.userMail = _mailer.text.trim();
        MyInheritor.of(context)?.uid = user.uid;

        city0 = _citier.text.trim().toLowerCase();
        town0 = _towner.text.trim().toLowerCase();
        city1 = "yeni güncellemeyi bekleyin";
        town1 = "yeni güncellemeyi bekleyin";
        city2 = "yeni güncellemeyi bekleyin";
        town2 = "yeni güncellemeyi bekleyin";
        takerOrg = "$city0/$town0 Belediyesi";

        if (MyInheritor.of(context)?.isGiver == true) {

          giverDistricts0 = _districter.text.trim().toLowerCase();
          giverAdress0 = _giverAdresser0.text.trim().toLowerCase();
          giverDistricts1 = "yeni güncellemeyi bekleyin";
          giverAdress1 = "yeni güncellemeyi bekleyin";
          giverDistricts2 = "yeni güncellemeyi bekleyin";
          giverAdress2 = "yeni güncellemeyi bekleyin";
          String fullAdress0 = "$giverDistricts0 $giverAdress0 $town0 / $city0";
          String fullAdress1 = "yeni güncellemeyi bekleyin";
          String fullAdress2 = "yeni güncellemeyi bekleyin";

          DocumentReference ref_user = await FirebaseFirestore.instance.collection("giverUsers").add({
            "userName": MyInheritor.of(context)?.userName, "userMail": user.email, "registerDate": DateTime.now(),
            "userAuthid": user.uid, "totalWeights_allTimes": 0, "takerOrg": takerOrg,
            "city0": city0, "town0": town0, "giverDistricts0" : giverDistricts0, "giverAdress0": giverAdress0,
            "fullAdress0": fullAdress0,
            "city1": city1, "town1": town1, "giverDistricts1" : giverDistricts1, "giverAdress1": giverAdress1,
            "fullAdress1": fullAdress1,
            "city2": city2, "town2": town2, "giverDistricts2" : giverDistricts2, "giverAdress2": giverAdress2,
            "fullAdress2": fullAdress2,
          });

        } else if (MyInheritor.of(context)?.isTaker == true) {

          String allDistricts_S = _districter.text.trim().toLowerCase();
          allDistricts = allDistricts_S.split(", ");

          DocumentReference ref_user = await FirebaseFirestore.instance.collection("takerUsers").add({
            "userName": MyInheritor.of(context)?.userName, "userMail": user.email, "registerDate": DateTime.now(),
            "userAuthid": user.uid, "city0": city0, "town0": town0, "allDistricts" : allDistricts,
            "districtsToTakeWaste": districtsToTakeWaste,
            "totalWeights_unAnswered":0, "paperWeights_unAnswered": 0, "glassWeights_unAnswered": 0,
            "plasticWeights_unAnswered": 0, "metalWeights_unAnswered": 0, "electronicWeights_unAnswered": 0,
            "packWeights_unAnswered": 0, "otherWeights_unAnswered": 0, "takenNotificationCount": 0,
          });

        }

        logOut();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, elevation: 50,
          content: const Text( "KAYDINIZ BAŞARIYLA GERÇEKLEŞTİRİLDİ. ŞİMDİ UYGULAMAYA TEKRAR GİRİŞ "
              "YAPARAK KULLANMAYA BAŞLAYABİLRİSNİZ.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          duration: const Duration(seconds: 15),
          action: SnackBarAction(label: "Gizle", textColor: Colors.indigo, onPressed: () => SnackBarClosedReason.hide,),
        ));
      }

    } catch (e) {

      AlertDialog alertDialog = AlertDialog(
        title: const Text("Error"),
        content: Text(e.toString(), style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ); showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void logIn() async {
    dynamic user_map;   dynamic user_id;    dynamic user_ref;

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _mailer.text.trim(), password: _passworder.text.trim()
      );
      final User? user = userCredential.user;

      if (user != null) {
        MyInheritor.of(context)?.userName = _namer.text.trim();
        MyInheritor.of(context)?.userMail = _mailer.text.trim();
        MyInheritor.of(context)?.uid = user.uid;

        if (MyInheritor.of(context)?.isGiver) {
          
          await FirebaseFirestore.instance.collection("giverUsers").where("userMail",
              isEqualTo: MyInheritor.of(context)?.userMail ).get().then((users) => users.docs.forEach((_user) {
                user_map = _user.data();
                user_id = _user.id;
                user_ref = _user.reference;

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                    GiverHomePage(user_map: user_map, user_id: user_id, user_ref: user_ref,)));
          }));

        } else if (MyInheritor.of(context)?.isTaker) {

          await FirebaseFirestore.instance.collection("takerUsers").where("userMail",
              isEqualTo: MyInheritor.of(context)?.userMail ).get().then((users) => users.docs.forEach((_user) {
                user_map = _user.data();
                user_id = _user.id;
                user_ref = _user.reference;

                _user.reference.collection("takenNotifications").where("isAnswered", isEqualTo: false).get()
                    .then((givers) => givers.docs.forEach((giver) {

                  int giverDistrictTotalWeight = giver.get("paperWeight") + giver.get("glassWeight") +
                      giver.get("plasticWeight") + giver.get("metalWeight") + giver.get("electronicWeight") +
                      giver.get("packWeight") + giver.get("otherWeight");
                    }));

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                    TakerHomePage(user_map: user_map, user_id: user_id, user_ref: user_ref)));
          }));

        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, elevation: 50,
          content: Text( "Hoşgeldiniz ${MyInheritor.of(context)?.userName}",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          duration: const Duration(seconds: 15),
          action: SnackBarAction(label: "Gizle", textColor: Colors.indigo, onPressed: () => SnackBarClosedReason.hide,),
        ));

      }

    } catch (e) {
      AlertDialog alertDialog = AlertDialog(
        title: const Text("Error"),
        content: Text(e.toString(), style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ); showDialog(context: context, builder: (_) => alertDialog);
    }

  }

  void justMunicipalityAlert() {
    AlertDialog alertDialog = const AlertDialog(
      title: Text("Şimdilik sadece İlçe Belediye seçimi aktiftir. Diğer kurumlar için "
          "güncellemeleri bekleyiniz."),
    ); showDialog(context: context, builder: (_) => alertDialog);
  }
}


