package com.koreaIT.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.demo.service.RecommendPointService;
import com.koreaIT.demo.vo.RecommendPoint;
import com.koreaIT.demo.vo.ResultData;
import com.koreaIT.demo.vo.Rq;

@Controller
public class UsrRecommendPointController {
	private RecommendPointService recommendPointService;
	private Rq rq;
	
	public UsrRecommendPointController(RecommendPointService recommendPointService, Rq rq) {
		this.recommendPointService = recommendPointService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/recommendPoint/getRecommendPoint")
	@ResponseBody
	public ResultData<RecommendPoint> getRecommendPoint(String relTypeCode, int relId) {
		RecommendPoint recommendPoint = recommendPointService.getRecommendPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		
		if(recommendPoint == null) {
			return ResultData.from("F-1", "기록 없음");
		}
		
		return ResultData.from("S-1", "좋아요 조회", recommendPoint);
	}
	
	@RequestMapping("/usr/recommendPoint/doRecommendPoint")
	@ResponseBody
	public String doRecommendPoint(int relId, String relTypeCode, boolean recommendBtn) {
		
		if(recommendBtn) {
			recommendPointService.deletePoint(rq.getLoginedMemberId(), relTypeCode, relId);
			return "좋아요 취소 성공";
		}
		
		recommendPointService.insertPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		return "좋아요 성공";
	}
}
