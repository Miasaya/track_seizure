import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/header.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'package:track_seizure/component/Log_StatsComponents.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      LogHeader(text: "Settings"),
      DraggableScrollableSheet(
          initialChildSize: 0.90,
          maxChildSize: 0.90,
          builder: (context, scrollController) {
            return Container(
                padding: EdgeInsets.only(right: 15.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0))),
                child: ListView.builder(
                  itemCount: settings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(settings[index].title, style: kSettingsTitle),
                      subtitle:
                          Text(settings[index].subtitle, style: kLogTypeStyle),
                      trailing: settings[index].icon,
                      onTap: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) => BottomSheetSettingsContainer(
                                  warningText: settings[index].warningText,
                                  onPress: settings[index].onPress,
                                ));
                      },
                    );
                  },
                ));
          })
    ]);
  }
}

class Settings {
  Icon icon;
  String title;
  String subtitle;
  String warningText;
  Function onPress;
  Settings(
      {this.icon, this.title, this.subtitle, this.warningText, this.onPress});
}

final settings = [
  Settings(
      icon: Icon(Feather.bell, size: 25),
      title: 'Manage Notifications',
      subtitle: 'Choose when the daily reminder pop up',
      warningText: "Bla bla bla",
      onPress: null),
  Settings(
    icon: Icon(Feather.upload, size: 25),
    title: 'Export Data',
    subtitle: 'Export the database to a .csv file',
  ),
  Settings(
    icon: Icon(Feather.download, size: 25),
    title: 'Import Data',
    subtitle: 'Import a database from a .csv file',
  ),
  Settings(
      icon: Icon(Feather.trash, size: 25),
      title: 'Erase Data',
      subtitle: 'Clear the database',
      warningText: "This will erase all your data, proceed ?",
      onPress: () {
        DatabaseService.db.deleteAll();
        }),
];

class BottomSheetSettingsContainer extends StatelessWidget {
  BottomSheetSettingsContainer({this.onPress, this.warningText});

  final Function onPress;
  final String warningText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: kLogListShadow,
                spreadRadius: 2,
                offset: Offset(0, -3.0))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 15,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                  icon: Icon(Feather.chevron_up),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Text(warningText, style: kWarningStyle),
              SizedBox(height: 20,),
              RaisedButton(
                onPressed: onPress,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.red[400],
                child: Container(
                    height: 42,
                    width: 160,
                    child: Icon(
                      Feather.check,
                      color: Colors.white,
                    )),
              ),
            ]),
      ),
    );
  }
}
