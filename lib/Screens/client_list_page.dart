import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dbHelper/client_crud.dart';
import '../models/client.dart';
import 'update_client_page.dart';
import 'insert_client_page.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  _ClientListPageState createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  List<Client> clientList = [];
  late final bool useMaterial3;

  @override
  void initState() {
    super.initState();
    fetchClients();
  }

  Future<void> fetchClients() async {
    clientList = await getAllClients();
    setState(() {});
  }

  Future<void> _showDeleteConfirmationDialog(Client client) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to delete the client "${client.type} ${client.responsable}"?'),
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
                await deleteClient(client.mongoId);
                Fluttertoast.showToast(
                  msg:
                      "Successfully deleted client ${client.type} ${client.responsable}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                fetchClients();
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
      body: clientList.isEmpty
          ? Center(child: Text('No clients available'))
          : ListView.builder(
              itemCount: clientList.length,
              itemBuilder: (context, index) {
                final client = clientList[index];
                return ListTile(
                  title: Text(client.type),
                  subtitle: Text('Responsable: ${client.responsable}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateClientPage(client: client),
                            ),
                          ).then((_) => fetchClients());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmationDialog(client),
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
              builder: (context) => InsertClientPage(),
            ),
          ).then((_) => fetchClients());
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
