import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

 Future<void>getTime() async {

   try{
     //make request
     Response response = await get('https://worldtimeapi.org/api/timezone/$url');
     Map data = jsonDecode(response.body);
     //get props from data
     String datetime=data['utc_datetime'];
     String offset=data['utc_offset'].substring(1,3);


     //create datetime object

     DateTime now=DateTime.parse(datetime);
     now = now.add(Duration(hours:int.parse(offset)));

     //set the time property
     isDayTime= now.hour > 6 && now.hour < 20 ? true : false;
     time=DateFormat.jm().format(now);

   }catch(e){
     print('CAUGHT ERROR: $e');
     time='could not get time data';

   }



  }
}