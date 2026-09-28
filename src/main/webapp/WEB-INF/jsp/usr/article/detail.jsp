<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="DETAIL"/>
	
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/toastUiEditorLib.jsp" %>

	<script>
		$(function() {
			getRecommendPoint();
			
			$('#recommendBtn').click(function() {
				let recommendBtn = $('#recommendBtn').hasClass('btn-active');		
						
				$.ajax({
					url : "../recommendPoint/doRecommendPoint",
					method : "get",
					data : {
						"relTypeCode" : "article",
						"relId" : ${article.id },
						"recommendBtn" : recommendBtn
					},
					dataType : "text",
					success : function(data){
					},
					error : function(xhr, status, error){
						console.error("ERROR : " + status + " - " + error);
					}
				})
				
				location.reload();
			})
		})
		
		const getRecommendPoint = function(){
			$.ajax({
				url : "../recommendPoint/getRecommendPoint",
				method : "get",
				data : {
					"relTypeCode" : "article",
					"relId" : ${article.id }
				},
				dataType : "json",
				success : function(data){
					if (data.success) {
						$('#recommendBtn').addClass('btn-active');
					}
				},
				error : function(xhr, status, error){
					console.error("ERROR : " + status + " - " + error);
				}
			})
		}
	</script>

	<section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<div>
				<table class="table table-lg">
					<tr>
						<th>번호</th>
						<td>${article.id }</td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>수정일</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${article.hitCnt }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.writerName }</td>
					</tr>
					<tr>
						<th>추천</th>
						<td>
							<c:if test="${rq.loginedMemberId == 0}">
								<span>${article.point }개</span>
							</c:if>
							
							<c:if test="${rq.loginedMemberId != 0}">
								<button id="recommendBtn" class="btn btn-outline btn-xs mr-8">좋아요</button>
								<span>${article.point }개</span>
							</c:if>
							
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-viewer">
								<script type="text/x-template">${article.body }</script>
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="mt-2">
				<button class="btn btn-outline btn-sm" onclick="history.back();">뒤로가기</button>
				
				<c:if test="${rq.loginedMemberId == article.memberId}">
					<a class="btn btn-outline btn-sm" href="modify?id=${article.id }">수정</a>
					<a class="btn btn-outline btn-sm" href="doDelete?id=${article.id }" onclick="if(confirm('삭제 하시겠습니까?') == false) return false;" >삭제</a>
				</c:if>
			</div>
		</div>
	</section>
	
	<script>
		const replyForm_onSubmit = function(form) {
			form.body.value = form.body.value.trim();
			
			if (form.body.value.length < 2) {
				alert('2글자 이상 입력해주세요.');
				form.body.focus();
				return;
			}
			
			form.submit();
		}
		
		let originalForm = null;
		let originalId = null;
		
		const replyModify_getForm = function(replyId) {
			if(originalForm != null) {
				replyModify_cancle(originalId);
			}
			
			$.ajax({
				url : "../reply/getReplyContent",
				method : "get",
				data : {
					"id" : replyId
				},
				dataType : "json",
				success : function(data){ 
					
					let replyContent = $('#' + replyId);
					
					originalId = replyId;
					originalForm = replyContent.html();
					
					let addHtml = ` 
						<form action="../reply/doModify" method="post" onsubmit="replyForm_onSubmit(this); return false;">
							<input type="hidden" name="id" value="\${data.data.id }"/>
							<div class="mt-4 border border-gray-500 rounded-lg p-4">
								<div class="mb-2">\${data.data.writerName}</div>
								<textarea class="textarea textarea-bordered textarea-info w-full" name="body" placeholder="댓글을 작성해보세요.">\${data.data.body}</textarea>
								<div class="flex justify-end">
									<button onclick="replyModify_cancle(\${replyId});" class="btn btn-outline btn-sm mr-2">취소</button>
									<button class="btn btn-outline btn-sm">수정</button>
								</div>
							</div>
						</form>
					`;
					
					replyContent.empty().html(addHtml);
				},
				error : function(xhr, status, error){
					console.error("ERROR : " + status + " - " + error);
				}
			})
		}
		
		const replyModify_cancle = function(replyId) {
			let replyContent = $('#' + replyId);				
			
			replyContent.html(originalForm); 

			originalId = null;			
			originalForm = null;
		}
	</script>
	
	<section class="my-8 text-base">
		<div class="container mx-auto px-3">
			<div class="text-lg">댓글</div>
			
			<c:forEach var="reply" items="${replies }">
				<div id="${reply.id }" class="py-3 pl-16 border-bottom-line">
					<div class="flex justify-between items-end">
						<div class="text-yellow-800">${reply.writerName }</div>
						
						<c:if test="${rq.loginedMemberId == reply.memberId }">
							<div class="dropdown dropdown-end">
								<button class="btn btn-circle btn-ghost btn-sm">
							    	<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
							    </button>
								<ul tabindex="0" class="z-[1] p-2 shadow menu menu-sm dropdown-content bg-base-100 rounded-box w-24">
									<li><a onclick="replyModify_getForm(${reply.id })">수정</a></li>
									<li><a href="../reply/doDelete?id=${reply.id }" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a></li>
								</ul>
							</div>
							
						</c:if>
					</div>
					<div class="my-1 text-lg ml-2">${reply.getForPrintBody() }</div>
					<div class="text-xs text-gray-400">${reply.updateDate }</div>
				</div>
			</c:forEach>
			
			<c:if test="${rq.loginedMemberId != 0 }">
				<form action="../reply/doWrite" method="post" onsubmit="replyForm_onSubmit(this); return false;">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${article.id }"/>
					<div class="mt-4 border border-gray-500 rounded-lg p-4" >
						<div class="mb-2">${rq.loginedMemberNickname }</div>
						<textarea class="textarea textarea-bordered textarea-info w-full" name="body" placeholder="댓글 작성하기"></textarea>
						<div class="flex justify-end"><button class="btn btn-outline btn-sm">작성</button></div>
					</div>
				</form>
			</c:if>
		</div>
	</section>
	
<%@ include file="../common/footer.jsp" %>