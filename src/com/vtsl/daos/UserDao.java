package com.vtsl.daos;

import com.vtsl.beans.Userbean;

public class UserDao 
{
	public Userbean loginUser(Userbean currentUser) 
	{
		
		String curUserName=currentUser.getFname();
		String curUserPwd=currentUser.getPassword();

		return currentUser;
	}
	
	
	public void registerUser()
	{
		
	}
}
