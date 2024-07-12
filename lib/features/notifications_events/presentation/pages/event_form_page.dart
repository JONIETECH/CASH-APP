import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/add_event.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/event_bloc.dart';
import 'package:get_it/get_it.dart';

class AddEventPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => AddEventPage(),
      );

  final addEvent = GetIt.instance<AddEvent>();

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Event Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text = pickedDate.toString();
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                final event = Event(
                  id: UniqueKey().toString(), // Generating a unique ID
                  title: _titleController.text,
                  type: 'Reminder',
                  date: DateTime.parse(_dateController.text),
                );
                context.read<EventBloc>().add(AddNewEvent(event: event));
              },
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
