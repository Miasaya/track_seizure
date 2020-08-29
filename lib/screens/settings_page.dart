import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/header.dart';
import 'package:track_seizure/component/localNotifications.dart';
import 'package:track_seizure/component/database/googleDriveIntegration.dart';

int minNotification = 00;
int hourNotification = 22;

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final Notifications notification = Notifications();
  List settings;
  @override
  void initState() {
    super.initState();
    settings = [
      Settings(
          icon: Icon(Feather.bell, size: 25),
          title: 'Manage Notifications',
          subtitle:
              'Current time : ${hourNotification.toString()}h ${minNotification.toString()}',
          warningText: "Select desired time and tap on the check button",
          showTimePick: true,
          onPress: () {
            setState(() {});
            notification.removeReminder(1);
            notification.showNotificationDaily(
                1,
                'Does anything happened today?',
                'Tap here to track',
                hourNotification,
                minNotification);
          }),
      Settings(
          icon: Icon(Feather.upload, size: 25),
          title: 'Export Data',
          subtitle: 'Export the database to a .csv file',
          warningText:
              'This will export your database to a .csv file in the Documents folder, proceed ?',
          showTimePick: false,
          onPress: () {
            DatabaseService.db.export();
          }),
      Settings(
          icon: Icon(Feather.download, size: 25),
          title: 'Import Data',
          subtitle: 'Import a database from a .csv file',
          showTimePick: false,
          warningText:
              'Select a .csv file to be imported, \n WARNING : This will erase your current data',
          onPress: () {
            DatabaseService.db.import();
          }),
      Settings(
          icon: Icon(Feather.trash, size: 25),
          title: 'Erase Data',
          subtitle: 'Clear the database',
          warningText: "This will erase all your data, proceed ?",
          showTimePick: false,
          onPress: () {
            DatabaseService.db.deleteAll();
          }),
      Settings(
          icon: Icon(Feather.upload_cloud, size: 25),
          title: 'Sync Data with Google Drive',
          subtitle: 'Save your to your Drive account (NOT WORKING YET)',
          warningText:
              'This will export your database to a .csv file in your Drive, proceed ?',
          showTimePick: false,
          onPress: () {
            DatabaseService.db.exportDrive();
          }),
      Settings(
          icon: Icon(Feather.power, size: 25),
          title: 'Sign Out from Google Account',
          subtitle: 'Remove your google account information from the app',
          warningText: "App will no longer be usable, proceed ?",
          showTimePick: false,
          onPress: () async {
            await AuthManager.signOut();
          }),
    ];
  }

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
                                  showTimePick: settings[index].showTimePick,
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
  bool showTimePick;
  Settings(
      {this.icon,
      this.title,
      this.subtitle,
      this.warningText,
      this.onPress,
      @required this.showTimePick});
}

class BottomSheetSettingsContainer extends StatelessWidget {
  BottomSheetSettingsContainer(
      {@required this.onPress,
      @required this.warningText,
      @required this.showTimePick});

  final Function onPress;
  final String warningText;
  final bool showTimePick;
  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Widget buildButton(BuildContext wcontext, BuildContext tcontext) {
    Widget child;
    if (showTimePick) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            onPressed: () async {
              final selectedTime = await _selectTime(tcontext);
              if (selectedTime == null)
                return;
              else {
                hourNotification = selectedTime.hour;
                minNotification = selectedTime.minute;
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: kTopGradientColor,
            child: Container(
                height: 42,
                width: 100,
                child: Icon(
                  Feather.clock,
                  color: Colors.white,
                )),
          ),
          RaisedButton(
            onPressed: onPress,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.red[400],
            child: Container(
                height: 42,
                width: 100,
                child: Icon(
                  Feather.check,
                  color: Colors.white,
                )),
          ),
        ],
      );
    } else {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
        ],
      );
    }
    return child;
  }

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
              SizedBox(
                height: 20,
              ),
              buildButton(context, context),
            ]),
      ),
    );
  }
}
