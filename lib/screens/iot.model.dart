class IotModel{
  int led5,
      door5,
      led7,
      door7;

  IotModel(
    this.led5,
    this.door5,
    this.led7,
    this.door7,
  );
  IotModel.forMap(Map<dynamic, dynamic> map){
    led5 = map['led10305'];
    door5 = map['door10305'];
    led7 = map['led10307'];
    door7 = map['door10307'];
  }
  Map<dynamic,dynamic>toMap(){
    final Map<dynamic,dynamic> map = Map<dynamic,dynamic>();
    map['led10305']=led5 ; 
    map['door10305']=door5;
    map['led10307']=led7;
    map['door10307']=door7;
    return map;
  }
}