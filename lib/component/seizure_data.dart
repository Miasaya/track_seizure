import 'dart:convert';
import 'dart:async';

enum Type { absence, tc, other }

List<Seizure> seizureFromJson(String str) => List<Seizure>.from(json.decode(str).map((x) => Seizure.fromMap(x)));

String seizureToJson(List<Seizure> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Seizure {
    Seizure({
        this.date,
        this.type,
        this.length,
        this.feel,
        this.note,
    });

    String date;
    String type;
    int length;
    int feel;
    String note;

    factory Seizure.fromMap(Map<String, dynamic> json) => Seizure(
        date: json["Date"],
        type: json["Type"],
        length: json["Length"],
        feel: json["Feel"],
        note: json["Note"],
    );

    Map<String, dynamic> toMap() => {
        "Date": date,
        "Type": type,
        "Length": length,
        "Feel": feel,
        "Note": note,
    };
}

List getPercentageType (snapshot){
  int aType = 0; 
  int gType = 0;
  int oType = 0; 

  List typeList = List(); 
  snapshot.forEach((element) {typeList.add(element.type);});

  typeList.forEach((element) {
    if (element== 'Absence'){
      aType ++;
    } else if (element == 'Generalized'){
      gType ++;
    } else {
      oType ++;
    }
   });

  return ([aType/typeList.length,gType/typeList.length,oType/typeList.length]);


}