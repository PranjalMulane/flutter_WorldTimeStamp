import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for UI
  String time; //the time in that location
  String flag; //URL to an assets flag icon
  String url; //location url API endpoints
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url });

  Future<void> getTime() async{
    //make request

    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from the data

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //createbdate time object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 20  ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch (e){
      print('caught error: $e');
      time = 'could not get time date';

    }


  }

}

