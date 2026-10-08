package com.koreaIT.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String title;
	private String body;
	private int hitCnt;
	private int point;
	private int boardId;
	
	private String writerName;
	
	private String equipment;
	private String workStage;
	private String causeType;
	private String status;
	private Integer resolverId;
	
}