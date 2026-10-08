<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="${board.name }"/>

<%@ include file="../common/header.jsp" %>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		
		<div class="mb-2 text-base flex justify-between">
			<div ><span>총: ${articlesCnt } 개</span></div>
			<div>
				<form>
					<input name="boardId" type="hidden" value="${board.id }"/>
					<select class="select select-info select-sm" data-value="${searchKeywordType }" name="searchKeywordType">
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="title, body">제목 + 내용</option>
					</select>
					
					<input class="ml-2 input input-bordered input-info w-60 input-sm" name="searchKeyword" type="text" value="${searchKeyword}" placeholder="검색어를 입력해주세요." maxlength="20"/>
					
					<button class="ml-2 btn btn-outline btn-sm">검색</button>
				</form>
			</div>
		</div>
		
		<div>
			<table class="table table-lg">
				<thead class="text-lg">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>추천수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articles }">
						<tr class="hover">
							<td>${article.id }</td>
							<td class="hover:underline"><a href="detail?id=${article.id }">${article.title }</a></td>
							<td>${article.writerName }</td>
							<td>${article.regDate.substring(2, 16) }</td>
							<td>${article.hitCnt }</td>
							<td>${article.point }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<c:if test="${rq.loginedMemberId != 0}">
			<div class="mt-2 flex justify-end">
				<a class="btn btn-outline btn-sm" href="write?boardId=${board.id }">글쓰기</a>
			</div>
		</c:if>
		
		<div class="mt-2 flex justify-center">
			<div class="join">
				<c:set var="baseUri" value="?boardId=${board.id}&searchKeywordType=${searchKeywordType}&searchKeyword=${searchKeyword}" />
				
				<c:if test="${from != 1}">
					<a class="join-item btn btn-square btn-sm" href="${baseUri}&page=1">&lt;&lt;</a>
					<a class="join-item btn btn-square btn-sm" href="${baseUri}&page=${from - 1}">&lt;</a>
				</c:if>
				
				<c:forEach begin="${from}" end="${end}" var="i">
					<a class="join-item btn btn-square btn-sm ${page == i ? 'btn-active' : '' }" href="${baseUri}&page=${i}">${i}</a>
					
				</c:forEach>
				
				<c:if test="${end != pagesCnt}">
					<a class="join-item btn btn-square btn-sm" href="${baseUri}&page=${end + 1}">&gt;</a>
					<a class="join-item btn btn-square btn-sm" href="${baseUri}&page=${pagesCnt}">&gt;&gt;</a>
				</c:if>
				
			</div>
		</div>
		
	</div>
</section>

<%@ include file="../common/footer.jsp" %>