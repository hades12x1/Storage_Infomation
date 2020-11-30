import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storage_infomation/pages/GreetingsPage.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://p7.hiclipart.com/preview/955/126/554/lego-batman-2-dc-super-heroes-youtube-superhero-iphone-6-plus-batman-thumbnail.jpg'),
                        fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Text('Chuyenns', style: TextStyle(fontSize: 22, color: Colors.white),),
                  Text('nchuyen128@gmail.com', style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile', style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting', style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout', style: TextStyle(fontSize: 18),),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (BuildContext context) => new GreetingsPage())
              );
            },
          )
        ],
      )
    );
  }
}