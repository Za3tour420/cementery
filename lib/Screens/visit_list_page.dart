/*import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/visit.dart';
import 'update_visit_page.dart';
import 'insert_visit_page.dart';

class VisitListPage extends StatefulWidget {
  const VisitListPage({super.key});

  @override
  _VisitListPageState createState() => _VisitListPageState();
}

class _VisitListPageState extends State<VisitListPage> {
  List<Visit> visitList = [];

  @override
  void initState() {
    super.initState();
    fetchVisits();
  }

  // Fetch all visits from the database
  Future<void> fetchVisits() async {
    visitList = await getAllVisits();
    setState(() {});
  }

  // Show delete confirmation dialog
  Future<void> _showDeleteConfirmationDialog(Visit visit) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete the visit for "${visit.client}"?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await deleteVisit(visit.mongoId!);
                Fluttertoast.showToast(
                  msg: "Successfully deleted visit for ${visit.client}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                fetchVisits(); // Refresh the list after deletion
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visits'),
      ),
      body: visitList.isEmpty
          ? Center(child: Text('No visits available'))
          : ListView.builder(
              itemCount: visitList.length,
              itemBuilder: (context, index) {
                final visit = visitList[index];
                return ListTile(
                  title: Text('Client: ${visit.client}'),
                  subtitle: Text('Date: ${visit.date.toIso8601String()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit visit
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateVisitPage(visit: visit),
                            ),
                          ).then((_) => fetchVisits());
                        },
                      ),
                      // Delete visit
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmationDialog(visit),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertVisitPage(),
            ),
          ).then((_) => fetchVisits()); // Refresh the list after inserting a new visit
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}*/
