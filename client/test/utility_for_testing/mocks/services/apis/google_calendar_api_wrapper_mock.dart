import 'package:flutter/cupertino.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mockito/mockito.dart';
import 'package:project/services/apis/google_calendar_api_wrapper.dart';

class GoogleCalendarApiWrapperMock extends Mock
    implements GoogleCalendarApiWrapper {
  /// Create a new Event object and insert it into Google Calendar.
  Future insertEventInGoogleCalendar(BuildContext context, String eventName,
      String eventDescription, DateTime startTime) async {
    Event event = _createEventObject(eventName, eventDescription, startTime);
    _insertEvent(context, event);
  }

  /// Create and return a new Event object.
  Event _createEventObject(
      String eventName, String eventDescription, DateTime startTime) {
    Event event = Event(); // Create object of event
    event.summary = eventName; //Setting summary of object
    event.description = eventDescription;
    EventDateTime start = new EventDateTime(); //Setting start time
    start.dateTime = startTime;
    start.timeZone = "GMT+01:00";
    event.start = start;

    /// Since we don't know the favor's end time, we just set it to the start time.
    event.end = start;
    return event;
  }

  /// Use the Client object provided during GoogleSignIn to add the event into
  /// Google Calendar.
  void _insertEvent(BuildContext context, Event event) async {}
}
