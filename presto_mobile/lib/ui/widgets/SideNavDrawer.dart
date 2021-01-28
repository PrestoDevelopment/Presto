import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';

class SideNavDrawer extends StatelessWidget {
  final Function logoutTap;
  final Function shareTap;

  SideNavDrawer({
    this.logoutTap,
    this.shareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "Share with Friends",
              style: TextStyle(fontSize: 20.0, color: color1),
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
              style: TextStyle(fontSize: 20.0, color: color1),
            ),
            trailing: Icon(
              Icons.developer_board,
              color: color1,
            ),
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 20.0, color: color1),
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
