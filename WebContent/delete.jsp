<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제(암호확인)</title>
</head>
<body>
<form action="delete_ok.jsp" method="post">
	비밀번호 : <input type="password" name="pwd">
	<input type="button" value="삭 제" onclick="del_go(this.form)">
</form>
</body>
<script>
	function del_go(frm) {
		if (frm.pwd.value == "${bvo.pwd}") { //작성한 비밀번호와 세션에 저장된 암호가 일치하면
			var isDelete = confirm("정말 삭제하시겠습니까?");
			if (isDelete) {
				frm.submit();
			} else {
				history.back();
			} 
		} else { // 비밀번호가 일치하지 않을 때
			alert("비밀번호가 일치하지 않습니다");
			frm.pwd.value = "";
			frm.pwd.focus();
			return false;
		}
	}
</script>
</html>