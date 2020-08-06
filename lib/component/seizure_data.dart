
enum Type { absence, tc, other }

class Seizure {
  final DateTime date; 
  final Type type; 
  final int length;
  final int feel;
  final String note;

  Seizure({this.date,this.feel,this.length,this.note,this.type});

  Map<String,dynamic> toMap(){
    return {
      'date': date, 
      'type': type, 
      'length': length, 
      'feel' : feel, 
      'note' : note,
    };
  }
}
