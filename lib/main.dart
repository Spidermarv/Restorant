import 'package:flutter/material.dart';

void main() {
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Service',
      home: TableManagementScreen(),
    );
  }
}

class TableManagementScreen extends StatelessWidget {
  final List<TableData> tables = [
    TableData(id: 1, status: TableStatus.assigned, assignedTo: 'Jessica Lam HEO U', capacity: 4, occupied: 2, lastOrderTime: '16:21'),
    TableData(id: 10, status: TableStatus.busy, assignedTo: 'Sylvia Do', capacity: 4, occupied: 1, lastOrderTime: '17:25'),
    TableData(id: 11, status: TableStatus.assigned, assignedTo: 'Jessica Lam HEO U', capacity: 4, occupied: 2, lastOrderTime: '05:06'),
    TableData(id: 12, status: TableStatus.free, assignedTo: '', capacity: 4, occupied: 0, lastOrderTime: ''),
    TableData(id: 13, status: TableStatus.busy, assignedTo: 'Sylvia Do', capacity: 4, occupied: 1, lastOrderTime: '21:13'),
    TableData(id: 14, status: TableStatus.busy, assignedTo: 'Sylvia Do', capacity: 4, occupied: 1, lastOrderTime: '14:26'),
    TableData(id: 15, status: TableStatus.assigned, assignedTo: 'Jessica Lam HEO U', capacity: 4, occupied: 1, lastOrderTime: '16:04'),
    TableData(id: 16, status: TableStatus.busy, assignedTo: 'Sylvia Do', capacity: 4, occupied: 1, lastOrderTime: '21:24'),
    TableData(id: 17, status: TableStatus.free, assignedTo: '', capacity: 4, occupied: 0, lastOrderTime: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Services'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns like in the image
          childAspectRatio: 0.75, // Taller cards for a closer match
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: tables.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (tables[index].status == TableStatus.free) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductSelectionScreen(tableId: tables[index].id),
                  ),
                );
              }
            },
            child: Card(
              elevation: 4, // Slight elevation for a raised card effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              color: _getTableColor(tables[index].status),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left for table ID
                  children: [
                    // Table ID at the top
                    Center(
                      child: Text(
                        'T ${tables[index].id}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8), // Spacing between elements
                    // Assigned name in the middle
                    if (tables[index].assignedTo.isNotEmpty)
                      Center(
                        child: Text(
                          tables[index].assignedTo,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis, // Handle long names
                        ),
                      ),
                    Spacer(),
                    // Occupancy (bottom left) and time (bottom right)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${tables[index].occupied}/${tables[index].capacity}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        if (tables[index].lastOrderTime.isNotEmpty)
                          Text(
                            tables[index].lastOrderTime,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getTableColor(TableStatus status) {
    switch (status) {
      case TableStatus.free:
        return Colors.green;
      case TableStatus.busy:
        return Colors.red;
      case TableStatus.assigned:
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}

class ProductSelectionScreen extends StatelessWidget {
  final int tableId;

  ProductSelectionScreen({required this.tableId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Products for Table $tableId'),
      ),
      body: Center(
        child: Text('Product selection functionality goes here.'),
      ),
    );
  }
}

enum TableStatus { free, busy, assigned }

class TableData {
  final int id;
  final TableStatus status;
  final String assignedTo;
  final int capacity;
  final int occupied;
  final String lastOrderTime;

  TableData({
    required this.id,
    required this.status,
    required this.assignedTo,
    required this.capacity,
    required this.occupied,
    required this.lastOrderTime,
  });
}
