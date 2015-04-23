import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;



public class Test {

	public static void getIp(){
		java.net.InetAddress addr = null;  
        try {  
            addr = java.net.InetAddress.getLocalHost();  
        } catch (java.net.UnknownHostException e) {  
            e.printStackTrace();  
        }  
        byte[] ipAddr = addr.getAddress();  
        String ipAddrStr = "";  
        for (int i = 0; i < ipAddr.length; i++) {  
            if (i > 0) {  
                ipAddrStr += ".";  
            }  
            ipAddrStr += ipAddr[i] & 0xFF;  
        }  
        System.out.println(ipAddrStr);  
      
	}
	
	/**
	 * @author 肖长江
	 * @date 2014-1-9
	 * @todo TODO
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//getIp();
		System.out.println(URLDecoder.decode("%3F%3F.saiku"));
	}

}
