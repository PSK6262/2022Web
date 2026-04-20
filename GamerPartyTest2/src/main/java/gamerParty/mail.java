package gamerParty;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class mail {
	String host = "smtp.naver.com";
    String user = "depsociete62@naver.com"; 
    String sender = "depsociete62@naver.com";
    String password = "machineyoda11";
    String to,subject,text;
    	public mail(String to, String subject, String text)
    	{
    		this.to = to;
    		this.subject = subject;
    		this.text = text;
    	}
	    public int sendMail() {
	    Properties props = new Properties(); 
	    props.put("mail.smtp.starttls.enable", "true");
	    props.put("mail.smtp.host", host); 	
	    props.put("mail.smtp.port", 587); 
	    props.put("mail.smtp.auth", "true"); 
	    props.put("mail.smtp.ssl.protocols", "TLSv1.2");
	                                                                         
	    //인증	    
	    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
	        protected PasswordAuthentication getPasswordAuthentication() { 
	            return new PasswordAuthentication(user, password); 
	        } 
	    }); 
	    
	    try { 
	        MimeMessage message = new MimeMessage(session); 
	        //받는사람 메일
	        message.setFrom(new InternetAddress(sender)); 
	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); 
	
	        // 메일 제목 
	        message.setSubject(subject); 
	        // 메일 내용 
	        message.setText(text); 
	        // send the message 
	        Transport.send(message);
	        
	        return 1;
	    } catch (MessagingException e) {
	        e.printStackTrace();
	        return 0;
	    }
    }
}
