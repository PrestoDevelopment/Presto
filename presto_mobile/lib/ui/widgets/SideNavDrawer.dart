import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';
class SideNavDrawer extends StatelessWidget {
  final Color verificationColor;
  final Function logoutTap;
  final Function shareTap;

  SideNavDrawer({this.verificationColor, this.logoutTap, this.shareTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Email Verification',
              style: TextStyle(
                  fontSize: 20.0,
                  color: verificationColor,
              ),
            ),
            trailing: Icon(
              Icons.email,
              color: verificationColor,
            ),
          ),
          ListTile(
            title: Text(
              "Phone Verification",
              style: TextStyle(
                fontSize: 20.0,
                color: verificationColor
              ),
            ),
            trailing: Icon(
              Icons.phone,
              color: verificationColor,
            ),
          ),
          ListTile(
            title: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 20.0,
                color: color1
              ),
            ),
            trailing: Icon(
              Icons.notifications,
              color: color1,
            ),
            onTap: () {
              //In App Notification Page

              // Navigator.of(context)
              //     .push(MaterialPageRoute(
              //   builder: (context) =>
              //       InAppNotificationPage(),
              //   settings: RouteSettings(
              //       name: InAppNotificationPage.id),
              // ));
            },
          ),
          ListTile(
            title: Text(
              "Share with Friends",
              style: TextStyle(
                fontSize: 20.0,
                color: color1
              ),
            ),
            trailing: Icon(
              Icons.share,
              color: color1,
            ),
            onTap: shareTap,
          ),
          ListTile(
            title: Text(
              "About Us",
              style: TextStyle(
                fontSize: 20.0,
                color: color1
              ),
            ),
            trailing: Icon(
              Icons.developer_board,
              color: color1,
            ),
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 20.0,
                  color: color1
              ),
            ),
            trailing: Icon(
              Icons.power_settings_new,
              color: color1,
            ),
            onTap: logoutTap,
          )
        ],
      ),
    );
  }
}
