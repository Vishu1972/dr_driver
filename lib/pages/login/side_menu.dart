import 'package:dr_drivers/SlideRightRoute.dart';
import 'package:dr_drivers/pages/login/login.dart';
import 'package:dr_drivers/preferences/app_shared_preferences.dart';
import 'package:dr_drivers/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import '../../res/color.dart';
import 'local_history.dart';
class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to DR Driver',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/logo.png",
                        width: 100,
                        height: 100,
                      ),
                      Switch(value: value, onChanged: (newValue){
                        setState(() {
                          value = newValue;
                        });
                        CustomToast.showToastMessage(value ? "You are online now." : "You are offline now.");
                        PreferenceHelper.clearPreferenceData(PreferenceHelper.LOCATION_ON);
                        PreferenceHelper.setPreferenceBoolData(PreferenceHelper.LOCATION_ON, value);
                      })
                    ],
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
                color: AppColor.themeColor,
                ),
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text('Ride History'),
            onTap: () => {
              Navigator.push(context, SlideRightRoute(page: OngoingRides()))
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share With Friends'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Rate Our App'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: Text('App Privacy Policy'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Logout'),
            onTap: () {
              PreferenceHelper.clearPreferenceData(PreferenceHelper.TOKEN);
              PreferenceHelper.clearPreferenceData(PreferenceHelper.LOCATION_ON);
              PreferenceHelper.setPreferenceBoolData(PreferenceHelper.LOCATION_ON, false);

              Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (context) => Loginpage()),
                 (route) => false
             );
            },
          ),
        ],
      ),
    );
  }
}