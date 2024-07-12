import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_all_events.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/add_event.dart';
import 'package:finance_tracker/features/notifications_events/presentation/bloc/event_bloc.dart';

class EventListPage extends StatelessWidget {
  static route(GetAllEvents getAllEvents) => MaterialPageRoute(
        builder: (context) => EventListPage(getAllEvents: getAllEvents,),
      );
  final GetAllEvents getAllEvents;

  EventListPage({required this.getAllEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: BlocProvider(
        create: (context) => EventBloc(
          getAllEvents: getAllEvents,
          addEvent: context.read<AddEvent>(),
        )..add(LoadEvents()),
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is EventLoaded) {
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text('${event.type} - ${event.date}'),
                  );
                },
              );
            } else if (state is EventError) {
              return Center(child: Text('Failed to load events: ${state.message}'));
            } else {
              return Center(child: Text('No events found.'));
            }
          },
        ),
      ),
    );
  }
}
