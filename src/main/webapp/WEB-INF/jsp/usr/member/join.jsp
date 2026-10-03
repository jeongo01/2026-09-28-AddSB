<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="JOIN" />

<%@ include file="../common/header.jsp" %>

	 <script>
		let validLoginId = '';
		
		const joinForm_onSubmit = function(form) {
			form.loginId.value = form.loginId.value.trim();
			form.loginPw.value = form.loginPw.value.trim();
			form.loginPwChk.value = form.loginPwChk.value.trim();
			form.name.value = form.name.value.trim();
			form.nickname.value = form.nickname.value.trim();
			form.cellphoneNum.value = form.cellphoneNum.value.trim();
			form.email.value = form.email.value.trim();
			
			if(form.loginId.value.length == 0) {
				alert('아이디를 입력해주세요.');
				form.loginId.focus();
				return;
			}
			
			if(form.loginId.value != validLoginId) {
				alert(form.loginId.value + '는 사용할 수 없는 아이디입니다.')
				form.loginId.value = '';
				form.loginId.focus();
				return;
			}
			
			if(form.loginPw.value.length == 0) {
				alert('비밀번호를 입력해주세요.')
				form.loginPw.focus();
				return;
			}
			
			if(form.loginPwChk.value.length == 0) {
				alert('비밀번호를 확인 입력해주세요.')
				form.loginPwChk.focus();
				return;
			}
			
			if(form.loginPw.value != form.loginPwChk.value) {
				alert('비밀번호가 일치하지 않습니다.')
				form.loginPw.value = '';
				form.loginPwChk.value = '';
				form.loginPw.focus();
				return;
			}
			
			if(form.name.value.length == 0) {
				alert('이름을 입력해주세요.')
				form.name.focus();
				return;
			}
			
			if(form.nickname.value.length == 0) {
				alert('닉네임을 입력해주세요.');
				form.nickname.focus();
				return;
			}
			
			if(form.cellphoneNum.value.length == 0) {
				alert('전화번호를 확인해주세요.')
				form.cellphoneNum.focus();
				return;
			}
			
			if(form.email.value.length == 0) {
				alert('이메일을 입력해주세요.')
				form.email.focus();
				return;
			}
			
			form.submit();
		} 
		
		const loginIdDupChk = function(el) {
			el.value = el.value.trim();
			
			let loginIdDupChkMsg =$('#loginIdDupChkMsg')
			
			loginIdDupChkMsg.empty();  //  메시지 표시 칸의 내용을 비우는 jQuery 코드
			
			if(el.value.length == 0) {
				loginIdDupChkMsg.removeClass('text-green-500');
				loginIdDupChkMsg.addClass('text-red-500');
				loginIdDupChkMsg.html(`<span>아이디는 필수 입력 정보입니다.</span>`);
				return;
			}
			
			$.ajax({
				url: "loginIdDupChk",
				method: "get",
				data: {
					"loginId" : el.value
				},
				dataType: "json",
				success: function(data) {
					if(data.success) {
						loginIdDupChkMsg.removeClass('text-red-500');
						loginIdDupChkMsg.addClass('text-green-500');
						loginIdDupChkMsg.html(`<span>\${data.msg }</span>`);
						validLoginId = el.value;
					} else {
						loginIdDupChkMsg.removeClass('text-green-500');
						loginIdDupChkMsg.addClass('text-red-500');
						loginIdDupChkMsg.html(`<span>\${data.msg }</span>`);
						validLoginId = '';
					}
				},
				error: function(xhr, status, error) {
					console.error("ERROR : " + status + " - " + error);
				}
			})
			
		}		
	 </script>
	 
	 <section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<form action="doJoin" method="post" onsubmit="joinForm_onSubmit(this); return false;">
				<div>
					<table class="table table-lg">
						<tr height="110">
							<th>아이디</th>
							<td>
								<input class="input input-bordered input-info w-9/12" name="loginId"  type="text" placeholder="아이디를 입려해주세요." onblur="loginIdDupChk(this);"/>
								
								<div id="loginIdDupChkMsg" class="mt-2 text-sm h-5"></div>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input class="input input-bordered input-info w-9/12" name="loginPw" type="text" placeholder="비밀번호를 입력해주세요."/></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input class="input input-bordered input-info w-9/12" name="loginPwChk" type="text" placeholder="비밀번호 확인을 입력해주세요."/></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input class="input input-bordered input-info w-9/12" name="name" type="text" placeholder="이름을 입력해주세요."/></td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td><input class="input input-bordered input-info w-9/12" name="nickname" type="text" placeholder="닉네임을 입력해주세요."/></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input class="input input-bordered input-info w-9/12" name="cellphoneNum" type="text" placeholder="전화번호를 입력해주세요."/></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input class="input input-bordered input-info w-9/12" name="email" type="text" placeholder="이메일을 입력해주세요."/></td>
						</tr>
						<tr>
							<td class="text-center" colspan="2"><button class="btn btn-wide btn-outline btn-sm">회원가입</button></td>
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