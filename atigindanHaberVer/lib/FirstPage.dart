import 'package:atigindanhaberver/Helpers/MyInheritor.dart';
import 'package:atigindanhaberver/RegisterLoginPage.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade800,
        title: const Center(child: Text("Atığından Haber Ver",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 30,),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container( height: 50,
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    icon: Icon(Icons.supervised_user_circle),
                    label: Text("Atık Veren", style: TextStyle(fontSize: 20),),
                    onPressed: (){
                      MyInheritor.of(context)?.isGiver = true;
                      MyInheritor.of(context)?.isTaker = false;

                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLoginPage()));
                    },
                  ),
                ),
                SizedBox( height: 50,
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                    icon: const Icon(Icons.recycling),
                    label: const Text("Atık Toplayan", style: TextStyle(fontSize: 20),),
                    onPressed: (){
                      MyInheritor.of(context)?.isTaker = true;
                      MyInheritor.of(context)?.isGiver = false;

                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLoginPage()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Center(
              child: Card( elevation: 20,
                child: Container(
                  height: 300, width: 300,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Wrap( direction: Axis.vertical, spacing: 4, children: [
                  Wrap(direction: Axis.horizontal, spacing: 4, children: const [
                    Icon(Icons.copyright, size: 30, color: Colors.green),
                    Text("Hayatı Geri Dönüştür Projesi - 2023",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,
                        fontSize: 15),),
                  ]),
                  const Text("Tefenni Anadolu İmam Hatip Lisesi - Burdur",
                    style: TextStyle(color: Colors.green, fontSize: 13), ),
                  const Text("iletişim: omerkalfa1@gmail.com", style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}