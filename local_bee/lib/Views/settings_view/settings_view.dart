import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit Personal Information"),
            onTap: () {
              // TODO: Navigate to edit information page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditInfoView()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.upload_file),
            title: Text("Update Proof of Residency"),
            onTap: () {
              // TODO: Implement the upload functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () {
              // TODO: Implement the log out functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text("Delete Account"),
            onTap: () {
              // TODO: Implement the delete account functionality
            },
          ),
        ],
      ),
    );
  }
}

// TODO: Implement all subviews
class EditInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Information"),
      ),
      body: Center(
        child: Text("Edit info form goe"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement the save functionality
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
