import 'package:flutter/material.dart';

import 'widget/change_theme_button_widget.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Stanley'),
            accountEmail: Text('trip7.net@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/default.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://ichef.bbci.co.uk/news/976/cpsprodpb/5DCB/production/_123111042_opera.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.save),
            title: Text('Save'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Event'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text('Light or Dark mode'),
                //Switch(value: false, onChanged: (newvalue) {}),
                ChangeThemeButtonWidget(),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('About us'),
            onTap: () => null,
          ),
          ListTile(
            title: Text('Contact us'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => null,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Version',
                ),
                Text(''),
                Text(
                  ' 1.0.0',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
