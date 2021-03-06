import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI
  String time; // the time in that location
  String flag;
  String url;// location url for api endpoint
  bool isDaytime;// true or false

  WorldTime({this.location,this.flag,this.url});
  Future<void> getTime() async{
    // make the request
    Response response = await get('https://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    //print(data);

    // get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    //print(datetime);
    //print(offset);

    // create a date time object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    //time property
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time=DateFormat.jm().format(now);

  }

}
