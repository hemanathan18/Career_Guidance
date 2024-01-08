//package mcp.mailHandling;
//
//import com.google.api.services.calendar.Calendar;
//import com.google.api.services.calendar.model.Event;
//import com.google.api.services.calendar.model.EventDateTime;
//
//public class GoogleCalendarService {
//
//    // Method to create an event in Google Calendar
//    public static void createEvent(String studentMailContent, String mentorMailContent, Date startTime, Date endTime) {
//        // Initialize the Google Calendar API
//        Calendar service = // Initialize the Calendar service using credentials
//
//        // Create events
//        createEvent(service, "Student Event", studentMailContent, startTime, endTime);
//        createEvent(service, "Mentor Event", mentorMailContent, startTime, endTime);
//    }
//
//    // Method to create a Google Calendar event
//    private static void createEvent(Calendar service, String summary, String description, Date startTime, Date endTime) {
//        try {
//            Event event = new Event()
//                .setSummary(summary)
//                .setDescription(description);
//
//            EventDateTime start = new EventDateTime()
//                .setDateTime(new DateTime(startTime))
//                .setTimeZone("UTC");
//            event.setStart(start);
//
//            EventDateTime end = new EventDateTime()
//                .setDateTime(new DateTime(endTime))
//                .setTimeZone("UTC");
//            event.setEnd(end);
//
//            // Insert the event
//            service.events().insert("primary", event).execute();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
//}