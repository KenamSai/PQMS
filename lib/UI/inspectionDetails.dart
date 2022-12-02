import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pqms/ModelClass/importApplModelClass.dart';
import 'package:pqms/reusable/image.dart';
import 'package:pqms/reusable/text.dart';
import 'package:pqms/routes/AppRoutes.dart';
import 'package:pqms/sharedpreference/preference.dart';
import 'package:pqms/sharedpreference/sharedpreference.dart';



class Inspectiondetails extends StatefulWidget {
  const Inspectiondetails({super.key});

  @override
  State<Inspectiondetails> createState() =>
      _Inspectiondetails();
}

class _Inspectiondetails extends State<Inspectiondetails> {
  TextEditingController noofsamples = TextEditingController();
  TextEditingController samplesize = TextEditingController();
  TextEditingController inspectionplace = TextEditingController();
  TextEditingController inspectiondate = TextEditingController();
  TextEditingController inspectionremarks = TextEditingController();
  TextEditingController quantityfound = TextEditingController();
  TextEditingController dutyofficer = TextEditingController();
  DataDetails? modelDetails;
  bool? treatment;
  var selectedDate;
   dynamic _image;
    void pickImage() async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("UAT-PQMS"),
        backgroundColor: Colors.green[900],
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName("/Dashboard"),
              );
            },
            child: Icon(
              Icons.home,
              size: 50,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage("assets/bg.png"),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    "    Import Inspection  Entry",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 14,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextC(
                      controller: dutyofficer,
                      labeltext: 'Duty Officer',
                    )),

                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextC(
                      controller: noofsamples,
                      labeltext: 'No of Samples',
                    )),

                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextC(
                      controller: samplesize,
                      labeltext: 'Sample Size',
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextC(
                      controller: inspectionplace,
                      labeltext: 'Inspection Place',
                    )),

                //child: Icon(Icons.calendar_month),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Inspection Date",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: () async {
                          selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            var dateTime =
                                DateTime.parse(selectedDate.toString());
                            var formate1 =
                                "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                            print(formate1);
                            inspectiondate.text = formate1;
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    controller: inspectiondate,
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextC(
                      controller: inspectionremarks,
                      labeltext: 'Inspection Remarks',
                    )),

                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextC(
                      controller: quantityfound,
                      labeltext: 'Quantity Found',
                    )),
                          
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          " Capture Image",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                           
                           child:ImgPicker(), 
                            
                          ),
                          Expanded(
                            flex: 1,
                            child: ImgPicker(),
                          ),
                          Expanded(
                            flex: 1,
                            child: ImgPicker(),)
                        ],
                      )
                          
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
               child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        width: 400,
                        height: 32.0,
                        child: Center(
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
              
      ),
        
    
    ],),),);
  }}