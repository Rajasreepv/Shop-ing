import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  late DatabaseReference usersRef;
  List<Map<dynamic, dynamic>> usersList = [];
  late List<String> allUserIDs = [];
  final customStyle = TextStyle(
      fontSize: 20.0,
      fontStyle: FontStyle.italic,
      color: const Color.fromARGB(255, 74, 13, 8),
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);
  @override
  void initState() {
    super.initState();
    usersRef = FirebaseDatabase.instance.ref().child('users');
    print(usersRef);
    getAllUserIDs();
    getUsersList();
  }

  Future<void> getAllUserIDs() async {
    try {
      DatabaseEvent event = await usersRef.once();
      DataSnapshot dataSnapshot = event.snapshot;
      // DataSnapshot dataSnapshot = await usersRef.once() as DataSnapshot;

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            dataSnapshot.value as Map<dynamic, dynamic>?;
        print(usersData);
        setState(() {
          allUserIDs = usersData!.keys.cast<String>().toList();
        });
      }
    } catch (error) {
      print('Error fetching user IDs: $error');
    }
  }

  Future<void> getUsersList() async {
    try {
      DatabaseEvent event = await usersRef.once();
      DataSnapshot dataSnapshot = event.snapshot;
      // DataSnapshot dataSnapshot = await usersRef.once() as DataSnapshot;

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            dataSnapshot.value as Map<dynamic, dynamic>?;

        usersData!.forEach((userId, userData) {
          usersList.add({
            'userId': userId,
            'name': userData['name'],
            'blocked': userData['blocked'] ?? false,
          });
        });
        setState(() {});
      } else {
        print("No users found");
      }
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  void toggleBlockStatus(int index) {
    setState(() {
      usersList[index]['blocked'] = !usersList[index]['blocked'];
      // Update the 'blocked' status in your Firebase database
      usersRef.child(usersList[index]['userId']).update({
        'blocked': usersList[index]['blocked'],
      }).then((_) {
        print('User status updated successfully!');
      }).catchError((error) {
        print('Failed to update user status: $error');
        // Revert the UI change if the database update fails
        setState(() {
          usersList[index]['blocked'] = !usersList[index]['blocked'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Management',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: usersList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text(
                        'User ID',
                        style: customStyle,
                      )),
                      DataColumn(
                          label: Text(
                        'Name',
                        style: customStyle,
                      )),
                      DataColumn(
                          label: Text(
                        'Current Status',
                        style: customStyle,
                      )),
                      DataColumn(
                          label: Text(
                        'Action',
                        style: customStyle,
                      )),
                    ],
                    rows: List<DataRow>.generate(
                      usersList.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text(usersList[index]['userId'])),
                          DataCell(Text(usersList[index]['name'])),
                          DataCell(Text(usersList[index]['blocked']
                              ? 'Blocked'
                              : 'Active')),
                          DataCell(
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () => toggleBlockStatus(index),
                              child: Text(
                                usersList[index]['blocked']
                                    ? 'Unblock'
                                    : 'Block',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
