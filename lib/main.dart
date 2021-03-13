import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=> runApp(
  MaterialApp(
    title: "WeatherApp",
    home: Home(),
  )
);

class Home extends StatefulWidget{
  State<StatefulWidget> createState (){
    return _HomeState();
  }
}

class _HomeState extends State<Home> {


  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var latitude;
  var longitude;
  var pressure;

  Future getWeather() async{

    http.Response response=await http.get("https://api.openweathermap.org/data/2.5/weather?id=673887&units=metric&appid=42f8394098cf2fcbe94680fc8bba14b3");
    var results=jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.latitude=results['coord']['lat'];
      this.longitude=results['coord']['lon'];
      this.pressure=results['main']['pressure'];
      /*print(temp);
      print(description);
      print(currently);
      print(humidity);
      print(windSpeed);*/
    });
  }

  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context ){
      return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightGreen,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Currently in Maramures",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Text(

                    temp != null ? temp.toString()+"\u00B0" : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null ? currently.toString() : "Loading",
                      style: TextStyle(
                          color:Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child:ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature"),
                      trailing: Text(temp!=null ? temp.toString()+"\u00B0":"Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description!=null ? description.toString():"Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.solidSun),
                      title: Text("Humidity"),
                      trailing: Text(humidity!=null ? humidity.toString():"Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(windSpeed!=null ? windSpeed.toString():"Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.whmcs),
                      title: Text("Pressure"),
                      trailing: Text(pressure!=null ? pressure.toString():"Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.map),
                      title: Text("Latitude"),
                      trailing: Text(latitude!=null ? latitude.toString():"Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.mapMarked),
                      title: Text("Longitude"),
                      trailing: Text(longitude!=null ? longitude.toString():"Loading"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
}
