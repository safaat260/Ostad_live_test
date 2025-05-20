import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final List<Map<String, String>> contact = [];

  void addContact() {
    final name = nameController.text.trim();
    final number = numberController.text.trim();

    if (name.isEmpty || number.isEmpty) {
      return;
    }

    setState(() {
      contact.add({'name': name, 'number': number});
      nameController.clear();
      numberController.clear();
    });
  }

  void deleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are you sure for Delete?"),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.red),
            onPressed: () {
              setState(() {
                contact.removeAt(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: addContact,
              child: const Text("Add"),
            ),
          ),
          Expanded(
            child: contact.isEmpty
                ? const Center(child: Text("No contacts yet."))
                : ListView.builder(
              itemCount: contact.length,
              itemBuilder: (context, index) {
                final c = contact[index];
                return GestureDetector(
                  onLongPress: () => deleteContact(index),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(c['name'] ?? ''),
                      subtitle: Text(c['number'] ?? ''),
                      trailing: const Icon(Icons.phone, color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
