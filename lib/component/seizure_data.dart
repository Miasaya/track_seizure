import 'dart:convert';

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

    factory Seizure.fromList(List<String> list) => Seizure(
        date: list[0],
        type: list[1],
        length: int.parse(list[2]),
        feel: int.parse(list[3]),
        note: list[4],
    );

    Map<String, dynamic> toMap() => {
        "Date": date,
        "Type": type,
        "Length": length,
        "Feel": feel,
        "Note": note,
    };
}

List getPercentageType (List<Seizure> snapshot){
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

  return ([(aType*100/typeList.length).roundToDouble(),(gType*100/typeList.length).roundToDouble(),(oType*100/typeList.length).roundToDouble()]);

}

List getNumberEntries (List<Seizure> snapshot,String month){
  int aType = 0; 
  int gType = 0;
  int oType = 0; 

  List snapshotCopy;
  List typeList = List(); 
  snapshotCopy = snapshot.where((element) => ((element.date).substring(3,5)==month)).toList();

  snapshotCopy.forEach((element) =>(typeList.add(element.type)));
  typeList.forEach((element) {
    if (element== 'Absence'){
      aType ++;
    } else if (element == 'Generalized'){
      gType ++;
    } else {
      oType ++;
    }
   });

  return([aType,gType,oType]);

}
