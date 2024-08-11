import 'package:chatzy/services/auth/auth_service.dart';
import 'package:chatzy/pages/settings_page.dart';
import 'package:chatzy/services/auth/auth_service.dart';
import 'package:flutter/material.dart';



    class MyDrawer extends StatelessWidget {
      const MyDrawer({super.key});

      void logout(){
// get auth service
        final auth = AuthService();
        auth.signOut();
      }
    
      @override
      Widget build(BuildContext context) {
        return Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
// logo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
            children: [
              DrawerHeader(child: Center(

                child: Icon(Icons.message,
                color: Theme.of(context).colorScheme.primary,size: 45,),
              ),
              ),

                //home list tile

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text(' H O M E '),
                    leading: Icon(Icons.home),
                    onTap: () {
                      //pop the drawer
                      Navigator.pop(context);
                    },
                  ),
                ),

              //settings tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text(' S E T T I N G S '),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      //pop the drawer
                      Navigator.pop(context);

                      // navigate to settings page
                      Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage(),
                      ),
                      ) ;
                    },
                  ),
                ),
            ],
          ),


            //settings tile
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                title: Text(' L O G O U T '),
                leading: Icon(Icons.settings),
                onTap: logout,
              ),
            )







          ],

          ),







          //logout button



        );
      }
    }
    