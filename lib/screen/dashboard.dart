import 'package:firebase_atuhenter/Services/authenticationservices.dart';
import 'package:firebase_atuhenter/databaseManager/databasemanager.dart';
import 'package:firebase_atuhenter/screen/applayout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AuthenticationServices uid = AuthenticationServices();
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _cell = TextEditingController();
  final TextEditingController _score = TextEditingController();
  final AuthenticationServices _auth = AuthenticationServices();

  List userlist = [];
  @override
  void initState() {
    super.initState();
    fetchUserinfo();
    fetchDatabaseList();
  }

  String userID = "";
  fetchUserinfo() async {
    User? getuser = FirebaseAuth.instance.currentUser;
    userID = getuser!.uid;
  }

  fetchDatabaseList() async {
    dynamic data = await DatabaseManager().getUserList(userID);

    if (data == null) {
      return;
    } else {
      setState(() {
        userlist = data;
      });
    }
  }

  updateData(
      String name, String gender, String cell, int score, String userID) async {
    await DatabaseManager().updateData(name, gender, cell, score, userID);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            onPressed: () {
              openDialogBox(context);
            },
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            onPressed: () async {
              await _auth.signOut().then(
                    (result) => Navigator.of(context).pop(true),
                  );
            },
            child: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
      body: userlist.isEmpty
          ? const Center(
              child: Text(
              "No Data Available",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ))
          : ListView.builder(
              itemCount: userlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppLayout.getHeight(10),
                      vertical: AppLayout.getHeight(3)),
                  child: Card(
                    child: ListTile(
                      title: Text("Name: ${userlist[index]['name']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gender: ${userlist[index]['gender']}"),
                          Text("Cell No.: ${userlist[index]['cell']}"),
                        ],
                      ),
                      leading: const CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/Profile_Image.png'),
                        ),
                      ),
                      trailing: Text("Score: ${userlist[index]['score']}"),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future openDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit User Details"),
          content: SizedBox(
            height: AppLayout.getHeight(200),
            child: Column(
              children: [
                TextField(
                  controller: _nameContoller,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: _gender,
                  decoration: const InputDecoration(hintText: "Gender"),
                ),
                TextField(
                  controller: _cell,
                  decoration: const InputDecoration(hintText: "Cell"),
                ),
                TextField(
                  controller: _score,
                  decoration: const InputDecoration(hintText: "Score"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  submitAction(context);
                  Navigator.pop(context);
                },
                child: const Text("Submit")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ],
        );
      },
    );
  }

  submitAction(BuildContext context) {
    updateData(_nameContoller.text, _gender.text, _cell.text,
        int.parse(_score.text), userID);
    _nameContoller.clear();
    _score.clear();
    _cell.clear();
    _gender.clear();
  }
}
