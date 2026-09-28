<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="LOGIN" />

<%@ include file="../common/header.jsp" %>

	<script>
		const loginForm_onsubmit() = function(form) {
			form.loginId.value = form.loginId.value.trim();
			form.loginPw.value = form.loginPw.value.trim();
			
			if(form.loginId.value.length == 0) {
				alert('아이디를 입력 해주세요.');
				form.loginId.focus();
				return;
			}
			if(form.loginPw.value.length == 0) {
				alert('비밀번호를 입력 해주세요.');
				form.loginPw.focus();
				return;
			}
			
			form.submit();
		}
	</script>

	<section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<form action="doLogin" method="post" onsubmit="loginForm_onsubmit(this); return false;">
				<div>
					<table class="table table-lg">
						<tr>
							<th>아이디</th>
							<td><input class="input input-bordered input-info w-9/12" name="loginId" type="text" placeholder="아이디를 입력해주세요."/></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input class="input input-bordered input-info w-9/12" name="loginPw" type="text" placeholder="비밀번호를 입력해주세요."/></td>
						</tr>
						<tr>
							<td class="text-center" colspan="2"><button class="btn btn-wide btn-outline btn-sm">로그인</button></td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="mt-2">
				<button class="btn btn-outline btn-sm" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</section>

<%@ include file="../common/footer.jsp" %>