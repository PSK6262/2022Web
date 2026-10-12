package gamerParty;

import java.io.InputStream;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class mail {
    private String host;
    private int port;
    private String user;
    private String password;
    private String to;
    private String subject;
    private String text;

    public mail(String to, String subject, String text) {
        this.to = to;
        this.subject = subject;
        this.text = text;
        loadConfig();
    }

    private void loadConfig() {
        Properties config = new Properties();
        try (InputStream in = getClass().getClassLoader().getResourceAsStream("config/smtp.properties")) {
            if (in != null) {
                config.load(in);
            } else {
                try (InputStream in2 = getClass().getClassLoader().getResourceAsStream("smtp.properties")) {
                    if (in2 != null) {
                        config.load(in2);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        this.host = config.getProperty("mail.host", "smtp.gmail.com");
        this.port = Integer.parseInt(config.getProperty("mail.port", "587"));
        this.user = config.getProperty("mail.username", "5asisdotcom@gmail.com");
        this.password = config.getProperty("mail.password", "");
    }

    public int sendMail() {
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", String.valueOf(port));
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user, "게이머 파티", "UTF-8"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject, "UTF-8");
            message.setText(text, "UTF-8");
            Transport.send(message);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
