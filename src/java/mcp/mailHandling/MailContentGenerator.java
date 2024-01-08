package mcp.mailHandling;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class MailContentGenerator {
  

    private static final String DATE_TIME_FORMAT = "yyyy-MM-dd hh:mma";
    
    public static String generateStudentMailContent(String bookedDate, String timeSlot) {
        try {
            String[] timeParts = timeSlot.split(" - ");
            String startTime = timeParts[0];
            String endTime = timeParts[1];

            return "Dear Student,\n\nYour booking has been confirmed for the session:\n"
                    + "Date: " + bookedDate + "\n"
                    + "Start Time: " + startTime + "\nEnd Time: " + endTime + "\nonline link: https://meet.google.com/mek-mpke-yax \n\nSincerely,\nMy Career Partner";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error in generating mail content";
        }
    }

    public static String generateMentorMailContent(String bookedDate, String timeSlot) {
        try {
            String[] timeParts = timeSlot.split(" - ");
            String startTime = timeParts[0];
            String endTime = timeParts[1];

            return "Dear Mentor,\n\nA student has booked a session with you:\n"
                    + "Date: " + bookedDate + "\n"
                    + "Start Time: " + startTime + "\nEnd Time: " + endTime + "\nonline link: https://meet.google.com/mek-mpke-yax \n\nSincerely,\nMy Career Partner";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error in generating mail content";
        }
    }
 
    
    
    
    //Previous code for extracting 15 minns included

//    public static String generateStudentMailContent(String bookedDate, String timeSlot) {
//        String dateTimeString = bookedDate + " " + timeSlot;
//        SimpleDateFormat inputFormat = new SimpleDateFormat(DATE_TIME_FORMAT);
//
//        try {
//            Date parsedDate = inputFormat.parse(dateTimeString);
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(parsedDate);
//
//            // Extract 15-minute session
//            int sessionDurationInMinutes = 15;
//            Date sessionEndTime = extractSessionEndTime(parsedDate, sessionDurationInMinutes);
//
//            String startTime = formatDateForMail(parsedDate);
//            String endTime = formatDateForMail(sessionEndTime);
//
//            return "Dear Student,\n\nYour booking has been confirmed for the session:\n"
//                    + "Date: " + formatDateForMail(parsedDate) + "\n"
//                    + "Start Time: " + startTime + "\nEnd Time: " + endTime + "\nonline link:https://meet.google.com/mek-mpke-yax \n\nSincerely,\nMy Career Partner";
//        } catch (ParseException e) {
//            e.printStackTrace();
//            return "Error in generating mail content";
//        }
//    }
//
//    public static String generateMentorMailContent(String bookedDate, String timeSlot) {
//        String dateTimeString = bookedDate + " " + timeSlot;
//        SimpleDateFormat inputFormat = new SimpleDateFormat(DATE_TIME_FORMAT);
//
//        try {
//            Date parsedDate = inputFormat.parse(dateTimeString);
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(parsedDate);
//
//            // Extract 15-minute session
//            int sessionDurationInMinutes = 15;
//            Date sessionEndTime = extractSessionEndTime(parsedDate, sessionDurationInMinutes);
//
//            String startTime = formatDateForMail(parsedDate);
//            String endTime = formatDateForMail(sessionEndTime);
//
//            return "Dear Mentor,\n\nA student has booked a session with you:\n"
//                    + "Date: " + formatDateForMail(parsedDate) + "\n"
//                    + "Start Time: " + startTime + "\nEnd Time: " + endTime + "\nonline link:https://meet.google.com/mek-mpke-yax \n\nSincerely,\nMy Career Partner";
//        } catch (ParseException e) {
//            e.printStackTrace();
//            return "Error in generating mail content";
//        }
//    }
private static Date extractSessionEndTime(Date startTime, int sessionDurationInMinutes) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startTime);
        calendar.add(Calendar.MINUTE, sessionDurationInMinutes);
        return calendar.getTime();
    }

    private static String formatDateForMail(Date date) {
        SimpleDateFormat outputFormat = new SimpleDateFormat(DATE_TIME_FORMAT);
        outputFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // Adjust the time zone as needed
        return outputFormat.format(date);
    }
   
}