/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SSGK;

/**
 *
 * @author java1
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

public class FTPcon {

    FTPClient client = new FTPClient();
    FileInputStream fis = null;
    boolean status;

    /**
     *
     * @param file
     * @return
     */
    public boolean upload(File file) {
        try {
            System.out.println("Check------------------------------------->1");
            client.connect("ftp.drivehq.com");
            client.login("myprojects","tp@1234$");
            client.enterLocalPassiveMode();
            fis = new FileInputStream(file);
            System.out.println("Check------------------------------------->2");
            status = client.storeFile("/kk/" + file.getName(), fis);
            //file path of drive storage
            client.logout();
            fis.close();

        } catch (Exception e) {
            System.out.println(e);
        }
        if (status) {
            System.out.println("success");
            return true;
        } else {
            System.out.println("failed");
            return false;

        }

    }
/*    public static void main(String args[]) {  
    	String fname="E:\\check.txt";
	FTPcon ftpcon=new FTPcon();
	File file=new File(fname);
	FileWriter fr;
	try {
		System.out.println("uploading");
		fr = new FileWriter(file);
		fr.write("hii i am okay");
		fr.flush();
    	ftpcon.upload(file );
    	System.out.println("completed");
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}*/
}
