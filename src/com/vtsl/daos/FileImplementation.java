package com.vtsl.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.vtsl.dbconnection.DBConnect;

public class FileImplementation 
{
	String fileId,fileName,file_owner,fileForwardBy,fileStatus,fileTaskBy,comm;
	Timestamp fileCreationTime,lastModificationTime;
	public Timestamp getLastModificationTime() {
		return lastModificationTime;
	}

	public String getComm() {
		return comm;
	}

	public void setComm(String comm) {
		this.comm = comm;
	}

	public void setLastModificationTime(Timestamp lastModificationTime) {
		this.lastModificationTime = lastModificationTime;
	}

	Connection con = DBConnect.getLocalDBConnection();
	ResultSet rs;
	PreparedStatement ps;
	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFile_owner() {
		return file_owner;
	}

	public void setFile_owner(String file_owner) {
		this.file_owner = file_owner;
	}

	public Timestamp getFileCreationTime() {
		return fileCreationTime;
	}

	public void setFileCreationTime(Timestamp fileCreationTime) {
		this.fileCreationTime = fileCreationTime;
	}

	public String getFileForwardBy() {
		return fileForwardBy;
	}

	public void setFileForwardBy(String fileForwardBy) {
		this.fileForwardBy = fileForwardBy;
	}

	public String getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}

	public String getFileTaskBy() {
		return fileTaskBy;
	}

	public void setFileTaskBy(String fileTaskBy) {
		this.fileTaskBy = fileTaskBy;
	}
	//
	public void detailsAboutFile(String filename,String fileid,String forwardby,Timestamp lastmodification,String status,String comments) 
	{
		fileName=filename;
		fileId=fileid;
		fileForwardBy=forwardby;
		lastModificationTime=lastmodification;
		comm=comments;
		fileStatus=status;
	}
	
	
}
