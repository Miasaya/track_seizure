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

    Map<String, dynamic> toMap() => {
        "Date": date,
        "Type": type,
        "Length": length,
        "Feel": feel,
        "Note": note,
    };
}
