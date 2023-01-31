import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/helpers/auth_helper.dart';

/**
 * References:
 * https://blog.codemagic.io/google-meet-events-in-flutter/
 * https://medium.com/flutter-community/flutter-use-google-calendar-api-adding-the-events-to-calendar-3d8fcb008493
 *
 */

class GoogleCalendarApiWrapper {
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
  void _insertEvent(BuildContext context, Event event) async {
    // Define the scopes for Google Calendar API
    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: AuthHelper().clientID(),
      scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'openid',
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/calendar',
      ],
    );
    await _googleSignIn.signIn();
    // For google calendar
    var client = (await _googleSignIn.authenticatedClient())!;
    var calendar = CalendarApi(client);
    String calendarId = "primary";
    try {
      var value = await calendar.events.insert(event, calendarId);

      if (value.status == "confirmed") {
        print(">>> Added event in Google Calendar: ${value.status}");
        showToast(context,
            "You have successfully added this event to your Google Calendar!");
      } else {
        showToast(context, "Unable to add this event to your Google Calendar!");
        print(">>> Unable to add event in Google Calendar: : ${value.status}");
      }
    } catch (e) {
      print(">>> Unable to add event in Google Calendar: " + e.toString());
    }
  }
}
