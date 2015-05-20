package com.yuhui.core.task;

import java.nio.charset.Charset;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class TaskTest {
	private static Logger log = LoggerFactory.getLogger(TaskTest.class);
 
	public void run() {
		for (int i = 0; i < 1; i++) {
			log.debug(i+" run......................................" + (new Date()));
		}

	}

	public void run1() {
		for (int i = 0; i < 1; i++) {
			log.debug(i+" run1......................................" + (new Date()));
		}
	}
	
	public static void main(String[] args) {
	    Map<String, Charset> charsets = Charset.availableCharsets();
	    for (Map.Entry<String, Charset> entry : charsets.entrySet()) {
	       System.out.println(entry.getKey());
	    }

	}
}
