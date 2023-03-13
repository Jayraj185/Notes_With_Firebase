import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_with_firebase/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:notes_with_firebase/Utils/AnimationRoute.dart';
import 'package:notes_with_firebase/Utils/FirebaseHelper/FirebaseHelper.dart';
import 'package:notes_with_firebase/Utils/ToastMessage.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.GetMonth();
    homeController.GetWeekday();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width / 15,
                ),
                Text(
                  "${homeController.weekday.value},",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  width: Get.width / 15,
                ),
                Text(
                  "${DateTime.now().day}",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.sp,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  width: Get.width / 30,
                ),
                Text(
                  "${homeController.month.value}",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.sp,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseHelper.firebaseHelper.ReadNotesData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
              );
            } else if (snapshot.hasData) {
              var docs = snapshot.data!.docs;
              homeController.NotesList.clear();
              homeController.CompletedTask.value = 0;
              for (var doc in docs) {
                Map docData = doc.data() as Map;
                homeController.NotesList.add({"notes": docData, "id": doc.id});
              }
              for(int i=0; i<homeController.NotesList.length; i++)
                {
                  if(homeController.NotesList[i]['notes']['status'] == true)
                    {
                      homeController.CompletedTask.value++;
                    }
                }
              return homeController.NotesList.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          height: Get.height / 12,
                          width: Get.width,
                          color: Colors.white,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: Get.width / 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: Get.height,
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      "${homeController.NotesList.length}",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "Created tasks",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Get.height,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      right: Get.width / 30),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${homeController.CompletedTask.value}",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Completed tasks",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.width / 6,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: homeController.NotesList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: Get.height / 12,
                                width: Get.width,
                                child: ListTile(
                                  onTap: () {
                                    FirebaseHelper.firebaseHelper
                                        .UpdateNotesData(
                                      id: homeController.NotesList[index]
                                          ['id'],
                                      note: homeController.NotesList[index]
                                          ['notes']['note'],
                                      status: homeController.NotesList[index]['notes']['status'] == true ? false : true,
                                    );
                                    homeController.NotesList[index]['notes']['status'] == true ? ToastMessage("Task UnCompleted", Colors.black) : ToastMessage("Task Completed", Colors.black);
                                  },
                                  leading: Icon(
                                    homeController.NotesList[index]['notes']
                                                ['status'] ==
                                            true
                                        ? Icons.check_circle_outlined
                                        : Icons.circle_outlined,
                                    color: homeController.NotesList[index]
                                                ['notes']['status'] ==
                                            true
                                        ? Colors.greenAccent
                                        : Colors.grey,
                                    size: Get.width / 12,
                                  ),
                                  title: Text(
                                    "${homeController.NotesList[index]['notes']['note']}",
                                    style: TextStyle(
                                        color: homeController
                                                        .NotesList[index]
                                                    ['notes']['status'] ==
                                                true
                                            ? Colors.grey
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          homeController.status.value = 1;
                                          homeController.NoteData.value = homeController.NotesList[index];
                                          homeController.txtUpdateNotes = TextEditingController(text: homeController.NoteData['notes']['note']);
                                          Get.toNamed('AddNotes');
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Colors.grey,
                                            size: Get.width / 15),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: "",
                                            content: Container(
                                              height: Get.height/6,
                                              width: Get.height/3,
                                              child: Column(
                                                children: [
                                                  Text("Are you sure delete this Task ?",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15.sp),),
                                                  SizedBox(height: Get.width/9,),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: (){
                                                          Get.back();
                                                        },
                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                                                        child: Text("Cancel",style: TextStyle(color: Colors.white,),),
                                                      ),
                                                      SizedBox(width: Get.width/6,),
                                                      ElevatedButton(
                                                        onPressed: (){
                                                          FirebaseHelper.firebaseHelper.DeleteNotesData(id: homeController.NotesList[index]['id']);
                                                          ToastMessage("Task Deleted", Colors.red);
                                                          Get.back();
                                                        },
                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
                                                        child: Text("Ok",style: TextStyle(color: Colors.white),),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          );
                                        },
                                        icon: Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.grey,
                                            size: Get.width / 15),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Please Add Notes",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    );
            } else {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: Get.height / 12,
                    width: Get.width,
                    child: ListTile(
                      leading: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey,
                        size: Get.width / 12,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit,
                                color: Colors.grey, size: Get.width / 15),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete_outline_rounded,
                                color: Colors.grey, size: Get.width / 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            homeController.status.value = 0;
           Navigator.of(context).push(animation());
          },
          child: Icon(
            Icons.add,
            size: Get.width / 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


