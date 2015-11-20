<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Predictor.com</title>
<style>
		
		table, th, td {
		    border: 1px solid black;
		    border-collapse: collapse;
		    margin-left:30%;
		   
		}
		th, td {
		    padding: 5px;
		}
		</style>
</head>
<body>
<%@ page import="java.io.BufferedWriter"
import="java.io.ByteArrayOutputStream"
import="java.io.FileWriter"
import="java.io.IOException"
import="java.io.InputStream"
import="java.net.URL"
import="java.net.URLEncoder"
import="java.text.SimpleDateFormat"
import="java.util.Date"
import="java.util.HashMap"
import="java.util.HashSet"
import="java.util.List"
import="java.util.Set"

import="javax.servlet.ServletException"
import="javax.servlet.annotation.WebServlet"
import="javax.servlet.http.HttpServlet"
import="javax.servlet.http.HttpServletRequest"
import="javax.servlet.http.HttpServletResponse"
import="javax.servlet.http.HttpSession"

import="org.apache.tomcat.jni.File"
import="org.json.simple.JSONArray"
import="org.json.simple.JSONObject"

import="com.restfb.Connection"
import="com.restfb.DefaultFacebookClient"
import="com.restfb.FacebookClient"
import="com.restfb.Parameter"
import="com.restfb.types.Album"
import="com.restfb.types.NamedFacebookType"
import="com.restfb.types.Photo"
import="com.restfb.types.Post"
import="com.restfb.types.User"
%>
	<% 	HttpSession session1=request.getSession();
 		HashMap<String,Integer> timeline_friends = (HashMap<String,Integer>)session1.getAttribute("timeline_friends");	
 		HashMap<String,Integer> shared_friends = (HashMap<String,Integer>)session1.getAttribute("shared_friends");	
 		HashMap<String,Integer> status_friends = (HashMap<String,Integer>)session1.getAttribute("status_friends");	
 		 HashMap<String,String> name_id=(HashMap<String,String>)session1.getAttribute("name_id");	
 		
 		List<Post> posts=(List<Post>)session1.getAttribute("posts");
 		User loginUser=(User)session1.getAttribute("loginUser");
 		int counter=(Integer)session1.getAttribute("counter");
 		int counter1=(Integer)session1.getAttribute("counter1");
 		int counter2=(Integer)session1.getAttribute("counter2");
 		int i=-1;
%>
<h1>Likes Predictor.com</h1>
	<table style="position:relative;width:40%;" >
    <tr>
    	<td><img src='https://graph.facebook.com/<c:out value="${loginUser.id}"/>/picture' /></td>
     </tr>   
     	<tr><td>Facebook ID:</td><td> <c:out value="${loginUser.id}" /></td></tr>
         <tr><td>Name: </td><td><c:out value="${loginUser.name}" /></td></tr>
         
        </table>
      
    		<c:forEach begin="0" end="7" var="loop">
    		<br>
    		<br>
    			<br>
    			<br>
    			
    		<table style="margin-left:38%;">		
    				<tr><th>Post Name</th></tr>
    		 <tr>	<td><c:out value="${posts.get(loop).getName()}"/> </td>
					<td><img src="<%=posts.get(i+1).getPicture()%>"/></td></tr>
		  </table>
		<% 		
		i++;
		
		if(posts.get(i).getType().equals("status")){
			%>
			<table style="position:relative;width:40%;" >
			<tr><th></th><th>Name</th><th>Probability(in %)</th></tr>
		<% 
			//	System.out.println("aap status dekhe ha");
		for (String name: status_friends.keySet()){
            String key =name.toString();
            float value = status_friends.get(name);  
            float a=(value/counter)*100;
            String image=name_id.get(name);
           // System.out.println(image);
            if(a>=1.0){%>
            		
                      <tr>  <td><img src='https://graph.facebook.com/<%=image %>/picture' /></td>
                         <td><%=key%></td><td><%=a%></td></tr>
                    
                     
                     
                        
	<% }}%>
	</table>
	<%}
		else if(posts.get(i).getType().equals("photo")||posts.get(i).getType().equals("link")||posts.get(i).getType().equals("video")){
			
			if((posts.get(i).getName().equals("Mobile Uploads"))||(posts.get(i).getName().equals("Mukesh's cover photo"))||(posts.get(i).getName().equals("Timeline Photos"))||(posts.get(i).getName().equals("Profile Pictures"))||(posts.get(i).getName().equals(loginUser.getName().toString()))){	
				%>
				<table style="position:relative;width:40%;" >
				<tr><th></th><th>Name</th><th>Probability(in %)</th></tr>
			<% 
				//System.out.println("aap timeline dekhe ha");
				for (String name: timeline_friends.keySet()){
		            String key =name.toString();
		            float value = timeline_friends.get(name);  
		            float a=(value/counter1)*100;
		            String image=name_id.get(name);
		           // System.out.println(image);
		            if(a>=1.0){%>
		           
		                      <tr>  <td><img src='https://graph.facebook.com/<%=image %>/picture' /></td>
		                        <td><%=key%></td><td><%=a%></td></tr>  
		                         
			<%}}
			%>
			</table>
			<%	
			}
			else{
				%>
				<table style="position:relative;width:40%;" >
				<tr><th></th><th>Name</th><th>Probability(in %)</th></tr>
			<% 	//System.out.println("aap shared dekhe ha");
				for (String name: shared_friends.keySet()){
		            String key =name.toString();
		            float value = shared_friends.get(name);  
		            float a=(value/counter2)*100;
		            String image=name_id.get(name);
		          //  System.out.println(image);
		            if(a>=1.0){%>
		            
		                      <tr>  <td><img src='https://graph.facebook.com/<%=image %>/picture' /></td>
		                          <td><%=key%></td><td><%=a%></td></tr>
		                         
		                     
			<%}}}}%>	
		
		</table>
		
			</c:forEach>
    		
 
     
</body>
</html>