<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="LOGIN" />

<%@ include file="../common/header.jsp" %>

	<script>
		const loginForm_onsubmit = function(form) {
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
		
		const togglePw = function(btn){
			const input = btn.previousElementSibling;
			if(input.type == 'password') {
				input.type='text'
				btn.innerText='숨기기'
			} else {
				input.type='password'
				btn.innerText='보기'
			}
			
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
							<td>
								<div class= "relative w-9/12">
									<input class="input input-bordered input-info pr-16 w-full" name="loginPw" type="password" placeholder="비밀번호를 입력해주세요."/>
									<button type="button" class="btn btn-ghost btn-sm absolute right-2 top-1/2 -translate-y-1/2" onclick="togglePw(this);">보기</button>
								</div>
							</td>
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