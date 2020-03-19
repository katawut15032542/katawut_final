import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:katawut_final/screens/iot.model.dart';

void main() => runApp(Home());
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool led5Bool=false,door5Bool=false,led7Bool=false,door7Bool=false;
  int led5Int = 0,door5Int = 0,led7Int = 0,door7Int = 0;
  String door5="status",door7="status";
  IotModel iotModel;

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  initState() {
    super.initState();
    readData();
  }
  Future <void> readData() async {
    print('Read Data Work');
    DatabaseReference databaseReference=firebaseDatabase.reference().child('final');
    await databaseReference.once().then((DataSnapshot dataSnapshot){
        print('dataSnapshot = ${dataSnapshot.value}');
        iotModel = IotModel.forMap(dataSnapshot.value);

        led5Int = iotModel.led5;
        door5Int = iotModel.door5;
        led7Int = iotModel.led7;
        door7Int = iotModel.door7;
        checkSwitch();

    });
  }
  Future <void> editDatabase() async{
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.reference().child('final');

    Map<dynamic,dynamic> map = Map();
    map['led10305']=led5Int ; 
    map['door10305']=door5Int;
    map['led10307']=led7Int;
    map['door10307']=door7Int;

    await databaseReference.set(map).then((response){
      print('Edit success');
    });

  }
  void checkSwitch(){
    setState(() {
      if(iotModel.led5 == 0){
        led5Bool = false;
      }else{
        led5Bool = true;
      }
      if(iotModel.door5 == 0){
        door5Bool = false;
      }else{
        door5Bool = true;
      }
      if(iotModel.led7 == 0){
        led7Bool = false;
      }else{
        led7Bool = true;
      }
      if(iotModel.door7 == 0){
        door7Bool = false;
      }else{
        door7Bool = true;
      }
    });
    print('led5=$led5Bool,door5=$door5Bool,led7=$led7Bool,door7=$door7Bool');
  }
  Widget led10305(){
    return Container(
      width: 180.0,
      child : Card(
        color: Colors.red.shade300,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('LED10305',style: TextStyle(
          fontSize: 16.0)),
              Row(
                children: <Widget>[
                  Text('OFF'),
                  Switch(value: led5Bool, onChanged: (bool value){
                    changeled5Bool(value);
                  },),
                  Text('ON')
                ],
              )
            ],
          )
        ),
      )

    );
  }
  void changeled5Bool(bool value) {
    setState(() {
      led5Bool = value;
      if (led5Bool) {
        led5Int = 1;
      } else {
        led5Int = 0;
      }
      editDatabase();
    });
  }

    Widget led10307(){
    return Container(
      width: 180.0,
      child : Card(
        color: Colors.yellow,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('LED10307',style: TextStyle(
          fontSize: 16.0)),
              Row(
                children: <Widget>[
                  Text('OFF'),
                  Switch(value: led7Bool, onChanged: (bool value){
                    changeled7Bool(value);
                  },),
                  Text('ON')
                ],
              )
            ],
          )
        ),
      )

    );
  }
  void changeled7Bool(bool value) {
    setState(() {
      led7Bool = value;
      if (led7Bool) {
        led7Int = 1;
      } else {
        led7Int = 0;
      }
      editDatabase();
    });
  }
  Widget buttonled5(){
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: SizedBox(
      height:50,
      width: 200,
      child: RaisedButton.icon(
        color: Colors.red.shade300,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0)
        ),
        onPressed: (){
        setState(() {
      door5Int = door5Int;
      if (door5Int==0) {
        door5Int = 1;
        door5="Open Door";
      } else {
        door5Int = 0;
        door5="Close Door";
      }
      editDatabase();
    });
      }, icon: Icon(Icons.mobile_screen_share), label: Text('10305:$door5')),),
    );
  }
    Widget buttonled7(){
    return Container(
      padding: new EdgeInsets.all(32.0),
      
      child: SizedBox(
      height:50,
      width: 200,
      child: RaisedButton.icon(
        color: Colors.yellow,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0)
        ),
        onPressed: (){
        setState(() {
      door7Int = door7Int;
      if (door7Int==0) {
        door7Int = 1;
        door7="Open Door";
      } else {
        door7Int = 0;
        door7="Close Door";
      }
      editDatabase();
    });
      }, icon: Icon(Icons.mobile_screen_share), label: Text('10305:$door7')),),
    );
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade200,
      body: SafeArea(child: Container(
        child: Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Room10305',style: TextStyle(
          fontSize: 40.0,color: Colors.red)) ,led10305(),buttonled5(),Text('Room10307',style: TextStyle(
          fontSize: 40.0,color: Colors.red)),led10307(),buttonled7()],
          ),
          ),
      )),
    );
  }
}