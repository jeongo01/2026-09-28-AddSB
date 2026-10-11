package com.koreaIT.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.koreaIT.demo.dao.ArticleDao;
import com.koreaIT.demo.dao.RecommendPointDao;
import com.koreaIT.demo.dao.ReplyDao;
import com.koreaIT.demo.vo.Article;

@Service
public class ArticleService {
	private ArticleDao articleDao;
	private ReplyDao replyDao;
	private RecommendPointDao recommendPointDao;
	
	public ArticleService(ArticleDao articleDao, ReplyDao replyDao, RecommendPointDao recommendPointDao) {
		this.articleDao = articleDao;
		this.replyDao = replyDao;
		this.recommendPointDao = recommendPointDao;
	}

	public void writeArticle(int memberId, String title, String body, int boardId, String equipment, String workStage, String causeType, String status, Integer resolverId) {
		articleDao.writeArticle(memberId, title, body, boardId, equipment, workStage, causeType, status, resolverId);
	}

	public Article getArticleById(int id) {
		return articleDao.getArticleById(id);
	}

	public void modifyArticle(int id, String title, String body) {
		articleDao.modifyArticle(id, title, body);
	}

	@Transactional
	public void deleteArticle(int id) {
		replyDao.deleteReplies("article", id);
		recommendPointDao.deletePoints("article", id);
		articleDao.deleteArticle(id);
	}

	public List<Article> getArticles(int boardId, String searchKeywordType, String searchKeyword, int limitStart, int itemsInAPage) {
		return articleDao.getArticles(boardId, searchKeywordType, searchKeyword, limitStart, itemsInAPage);
	}
	
	public int getLastInsertId() {
		return articleDao.getLastInsertId();
	}

	public Article forPrintArticle(int id) {
		return articleDao.forPrintArticle(id);
	}

	public int getArticlesCnt(int boardId, String searchKeywordType, String searchKeyword) {
		return articleDao.getArticlesCnt(boardId, searchKeywordType, searchKeyword);
	}

	public void increaseHitCnt(int id) {
		articleDao.increaseHitCnt(id);
	}

}
