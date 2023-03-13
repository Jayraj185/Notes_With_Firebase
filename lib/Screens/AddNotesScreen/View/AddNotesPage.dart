import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_with_firebase/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:notes_with_firebase/Utils/FirebaseHelper/FirebaseHelper.dart';
import 'package:notes_with_firebase/Utils/ToastMessage.dart';
import 'package:sizer/sizer.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("${homeController.status.value == 0 ? "Create" : "Update"} Note",style: TextStyle(color: Colors.white,fontSize: 21.sp,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(right: Get.width/21, left:  Get.width/21, top: Get.width/12),
          child: Column(
            children: [
              TextField(
                maxLength: 40,
                controller: homeController.status.value == 0 ? homeController.txtNotes : homeController.txtUpdateNotes,
                cursorColor: Colors.greenAccent,
                style: TextStyle(
                    fontSize: 15.sp
                ),
                decoration: InputDecoration(
                  hintText: "${homeController.status.value == 0 ? "Write" : "Update"} Note",
                  prefixIcon: Icon(Icons.sticky_note_2_rounded,size: 21.sp,),
                  prefixIconColor: Colors.greenAccent,
                  hintStyle: TextStyle(fontSize: 15.sp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.greenAccent,width: 2,),
                  ),
                ),
              ),
              SizedBox(height: Get.width/12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: Get.height/15,
                      width: Get.width/2.8,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      alignment: Alignment.center,
                      child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      if(homeController.status.value == 0)
                      {
                        FirebaseHelper.firebaseHelper.InsertNotesData(note: homeController.txtNotes.text);
                        ToastMessage("Task Created", Colors.green);
                      }
                      else
                      {
                        FirebaseHelper.firebaseHelper.UpdateNotesData(
                          id: homeController.NoteData['id'],
                          note: homeController.txtUpdateNotes.text,
                          status: homeController.NoteData['notes']['status'],
                        );
                        ToastMessage("Task Updated", Colors.blueAccent);
                      }
                      Get.back();
                    },
                    child: Container(
                      height: Get.height/15,
                      width: Get.width/2.8,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      alignment: Alignment.center,
                      child: Text("${homeController.status.value == 0 ? "Create" : "Update"}",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

