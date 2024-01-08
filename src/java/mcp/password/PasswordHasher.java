package mcp.password;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHasher {
    
//    public static void main(String [] args) throws NoSuchAlgorithmException
//    {
//        
//        System.out.println(doHash("admin@123"));
//    }

    public static String doHash(String password) throws NoSuchAlgorithmException {
        
        //Initializing the MessageDigest class by getting its instance and setting MD5 algorithm
        MessageDigest md = MessageDigest.getInstance("MD5");
        
        md.update(password.getBytes());//Retriving the password as bytes & prepared digest for hashing
        byte[] result=md.digest(); //generates hash of the password and store in byte array
        
        /*
        Directly converting a byte array not gives the desired hexadecimal value
        so string builder is used and format mentioned as "%02x" for hexadecimal
        */
        
        StringBuilder sb= new StringBuilder();
        
        for(byte b:result)
        {
         sb.append(String.format("%02x", b));
        }    
        
        return sb.toString();
       
    }

    
    
}
