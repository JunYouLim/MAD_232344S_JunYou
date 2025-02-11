import 'package:flutter/material.dart';

class BookingListPage extends StatelessWidget {
  final List<Map<String, String>> bookings;  // The list of saved bookings

  BookingListPage({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return ListTile(
            title: Text(booking['clinicName']!),
            subtitle: Text('Date: ${booking['date']} at ${booking['time']}'),
            leading: Icon(Icons.book_online),
            onTap: () {
              // You can add any action when a booking is tapped, like showing details.
            },
          );
        },
      ),
    );
  }
}