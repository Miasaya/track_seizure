import 'package:flutter/material.dart';

import 'home.dart';
import 'package:track_seizure/component/database/googleDriveIntegration.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _signInSilently();
  }
  Future<void> _signInSilently() async {
    var account = await AuthManager.signInSilently();
    if (account != null) {
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) {
          return HomePage();
          }));
    }
  }
  Future<void> _handleSignIn() async {
  var account = await AuthManager.signIn();
  if (account != null) {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) {
        return HomePage();
    }));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(
                'Log in using your Google account',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Log in'),
                onPressed: _handleSignIn,
              ),
              RaisedButton(
                child: Text('Skip'),
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) {
                      return HomePage();
                  }));
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

