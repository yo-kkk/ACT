package com.project.act.head.goal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;



public class 연습 {

	public static void main(String[] args) {
		
	
	SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM", Locale.KOREA );
	Date currentTime = new Date ();
	String mTime = mSimpleDateFormat.format ( currentTime );
	System.out.println ( mTime );




		}
	}


