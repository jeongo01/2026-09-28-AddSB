<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="MAIN" /> 

<%@ include file="../common/header.jsp" %>
	<section class="mt-8">
		<div class="container mx-auto">
			<div class="flex">
				<div class="modal-exam"><span>모달예시</span></div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div class="popUp-exam"><span>팝업예시</span></div>
			</div>
			
			<div class="layer-bg"></div>
			<div class="layer">
				<h1>MODAL</h1>
				<span class="close-btn-x">&times;</span>
				<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<span class="close-btn btn btn-wide btn-outline btn-text-color">CLOSE</span>
			</div>
		</div>
	</section>
	
<%@ include file="../common/footer.jsp" %>