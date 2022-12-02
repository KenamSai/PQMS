import 'package:flutter/material.dart';
import 'package:pqms/reusable/TextComponenet.dart';
import 'package:pqms/routes/AppRoutes.dart';
import '../reusable/Card_Component.dart';


class ViewSavedApplication extends StatefulWidget {
  const ViewSavedApplication({super.key});

  @override
  State<ViewSavedApplication> createState() => _ViewSavedApplicationState();
}

class _ViewSavedApplicationState extends State<ViewSavedApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 5, 140, 9),
        title: Text('UAT-PQMS'
        ),
        actions: [
          GestureDetector(
            onTap: null,
            child: Image.asset(
              "assets/logout.png",
              height: 30,
              width: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
       body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: FittedBox(
                  child: Text(
                    "Plant Quarantine Management System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/app_icon.png",
                height: 90,
                width: 90,
              ),
              SizedBox(
                height: 10,
              ),
              TextComponent(
                TextData: "Saved Applications",
                fontSize: 20,
              ),
              
              Center(
                child: Card(
                  color: Colors.black.withOpacity(0.1),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(context, AppRoutes.importsaved);
                        }),
                        child: CardComponent(
                            TextData: "Import Saved Applications",
                            icon: "assets/import.png"),
                      ),
                      GestureDetector(
                         onTap: (() {
                           Navigator.pushNamed(context, AppRoutes.exportsaved);
                        }),
                        child: CardComponent(
                            TextData: "Export Saved  Applications",
                            icon: "assets/export.png"),
                      ),
                     
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Image.asset(
        "assets/headerpic.png",
        width: double.infinity,
        height: 40,
      ),
    );
  }
}