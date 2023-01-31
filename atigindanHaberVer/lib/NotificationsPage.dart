import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NotificationsPage extends StatefulWidget{
  final user_map;   final user_id;   final user_ref;
  const NotificationsPage({super.key, required this.user_map, required this.user_id, required this.user_ref});

  @override
  State<StatefulWidget> createState() {
    return NotificationsPageState(this.user_map, this.user_id, this.user_ref);
  }

}

class NotificationsPageState extends State<NotificationsPage>{
  final user_map;   final user_id;   final user_ref;
  NotificationsPageState(this.user_map, this.user_id, this.user_ref);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gelen Bildirimleriniz"),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Tüm gelen bildirimleriniz tarih sıralmasına göre sondan başa doğru listelenmektedir. "
                "Okumadıklarınız koyu renklidir.",
              style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),

          Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("giverUsers").doc(user_id)
                  .collection("takenNotifications").orderBy("isSeen", descending: false)
                  .orderBy("sentDate_S", descending: true).snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasError){ return const Center( child:Icon(Icons.warning_amber, size: 50,));}

                else if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null){
                  return const Center( child: CircularProgressIndicator());}

                else {
                  QuerySnapshot querySnapshot = snapshot.data!;

                  return SizedBox( height: 600,
                    child: ListView.builder(
                      itemCount: querySnapshot.size,
                      itemBuilder: (context, index){

                        dynamic not_map = querySnapshot.docs[index].data()!;
                        dynamic not_id = querySnapshot.docs[index].id!;

                        return Card( elevation: 10,
                          child:ListTile(
                              tileColor: not_map["isSeen"] == false ? Colors.blue.shade100 : Colors.white,
                              title: const Text("Atık Toplama Bildirimi",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                              subtitle: Padding(padding: const EdgeInsets.all(5.0),
                                child: Wrap(direction: Axis.vertical, spacing: 5,
                                    children: [
                                      Wrap(children: [
                                        const Text("Atık Toplama Tarihi: "),
                                        Text(not_map["wasteTakeDate"],
                                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15,
                                            fontWeight: FontWeight.w600),)
                                      ]),
                                      Wrap(children: [
                                        const Text("Atık Toplama Saat Aralığı: "),
                                        Text(not_map["wasteTakeTime"],
                                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15,
                                            fontWeight: FontWeight.w600),)
                                      ]),
                                      Wrap(children: [
                                        const Text("Atık Toplama Noktası: "),
                                        Text(not_map["wasteTakePoint"],
                                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15,
                                            fontWeight: FontWeight.w600),)
                                      ]),
                                    ]),
                              ),
                              trailing: Card( color: not_map["isSeen"] == false ? Colors.blue.shade100 : Colors.white,
                                  elevation: 4, child: Text(not_map["sentDate_S"])),
                              onTap: () async {
                                await FirebaseFirestore.instance.collection("giverUsers").doc(user_id)
                                    .collection("takenNotifications").doc(not_id).update({
                                  "isSeen": true,
                                });
                              }
                          ),
                        );
                      },
                    ),
                  );

                }
              },
            ),
          ),
        ],
      ),
    );
  }

}
