import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  //Only Variable's
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtUpdateNotes = TextEditingController();
  RxString month = "".obs;
  RxString weekday = "".obs;
  RxList NotesList = [].obs;
  RxMap NoteData = {}.obs;
  RxInt status = 0.obs;
  RxInt CompletedTask = 0.obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();



  //Only Function's
  void GetMonth()
  {
    if(DateTime.now().month == 1)
    {
      month.value = "January";
    }
    else if(DateTime.now().month == 2)
    {
      month.value = "February";
    }
    else if(DateTime.now().month == 3)
    {
      month.value = "March";
    }
    else if(DateTime.now().month == 4)
    {
      month.value = "April";
    }
    else if(DateTime.now().month == 5)
    {
      month.value = "May";
    }
    else if(DateTime.now().month == 6)
    {
      month.value = "June";
    }else if(DateTime.now().month == 7)
    {
      month.value = "July";
    }
    else if(DateTime.now().month == 8)
    {
      month.value = "August";
    }
    else if(DateTime.now().month == 9)
    {
      month.value = "September";
    }
    else if(DateTime.now().month == 10)
    {
      month.value = "October";
    }
    else if(DateTime.now().month == 11)
    {
      month.value = "November";
    }
    else if(DateTime.now().month == 12)
    {
      month.value = "December";
    }

  }
  void GetWeekday()
  {
    if(DateTime.now().month == 1)
    {
      weekday.value = "Monday";
    }
    else if(DateTime.now().month == 2)
    {
      weekday.value = "Tuesday";
    }
    else if(DateTime.now().month == 3)
    {
      weekday.value = "Wednesday";
    }
    else if(DateTime.now().month == 4)
    {
      weekday.value = "Thursday";
    }
    else if(DateTime.now().month == 5)
    {
      weekday.value = "Friday";
    }
    else if(DateTime.now().month == 6)
    {
      weekday.value = "Saturday";
    }
    else if(DateTime.now().weekday == 7)
    {
      weekday.value = "Sunday";
    }

  }
}