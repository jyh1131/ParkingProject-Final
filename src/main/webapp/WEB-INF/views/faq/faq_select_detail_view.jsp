<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>질문 게시판</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script>
    $(document).ready(function() {
        var csrfToken = '${_csrf.token}';
        var csrfHeader = '${_csrf.headerName}';
        
        function deleteFaq(faq_code) {
            if (confirm("정말로 이 게시물을 삭제하시겠습니까?")) {
                $.ajax({
                    type: "POST",
                    url: "./FaqDelete",
                    data: { faq_code: faq_code },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(response) {
                        alert("게시글이 삭제되었습니다.");
                        window.location.href = "./FaqSelect";
                    },
                    error: function(xhr, status, error) {
                        alert("게시글 삭제에 실패했습니다.");
                    }
                });
            }
        }

        function deleteFaqAnswer(faq_code) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                $.ajax({
                    type: "POST",
                    url: "./FaqAnswerDelete",
                    data: { faq_code: faq_code },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(response) {
                        alert("댓글이 삭제되었습니다.");
                        window.location.href = "./FaqSelectDetail?faq_code=" + faq_code;
                    },
                    error: function(xhr, status, error) {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                });
            }
        }

        window.deleteFaq = deleteFaq;
        window.deleteFaqAnswer = deleteFaqAnswer;
    });
</script>
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

main {
	flex: 1;
}

footer {
	background-color: #6c757d;
	color: white;
	padding: 10px 0;
}

/* 버튼 스타일 */
button {
    background-color: #6c757d; /* 헤더의 배경색과 같은색으로 설정 */
    color: white; /* 글자색 흰색으로 설정 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 버튼 내부 여백 설정 */
    cursor: pointer; /* 커서 모양 변경 */
    margin-bottom: 10px; /* 버튼 아래 여백 설정 */
    margin-left: 30px;
}

button:hover {
    background-color: #5a6268; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

/* 버튼 컨테이너 */
.button-container {
    text-align: left; /* 가운데 정렬 */
    margin-top: 20px; /* 위 여백 설정 */
}
</style>
<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = '<c:url value="/logout" />';
        }
    }
</script>
</head>
<body>

   <header id="main-header" class="py-2 bg-secondary text-white">
      <div class="container">
         <div class="row align-items-start justify-content-between">
            <div class="col-md-4 text-left">
               <h1>
                  <i class="fas fa-lock-open"></i>P.K.-Management
               </h1>
            </div>
            <div class="col-md-7 d-flex align-items-center">
               <div>
                  <c:if test="${not empty sessionScope.customMemberDetails}">
                     <div>환영합니다, ${sessionScope.customMemberDetails.username}님</div>
                  </c:if>
               </div>
               &nbsp;&nbsp;&nbsp;&nbsp;
               <div>
                  <c:choose>
                     <c:when test="${empty sessionScope.customMemberDetails}">
                        <button onclick="location.href='<c:url value='/login' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그인
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberInsert' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 회원가입
                        </button>
                     </c:when>
                     <c:otherwise>
                        <button onclick="confirmLogout()"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그아웃
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberSelectDetail'/>'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 내정보 보기
                        </button>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'ADMIN'}">
                           <button onclick="location.href='<c:url value='/AdminView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 어드민 메뉴 보기
                           </button>
                        </c:if>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'MANAGER'}">
                           <button onclick="location.href='<c:url value='/ManagerView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 매니저 메뉴 보기
                           </button>
                        </c:if>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
         </div>
      </div>
   </header>

<main>

    <nav class="navbar navbar-expand-md bg-dark navbar-dark text-white">
        <div class="container">
            <div class="col-md-6">
                <h1>
                    <i class="fas fa-user-tag"></i> 게시판
                </h1>
            </div>
            <div id="toggle" class="navbar-collapse collapse">
                <ul class="navbar-nav">
                </ul>
                <ul class="navbar-nav ml-auto py-3 mb-3 pl-3 pr-3">
                    <li><a href="FaqSelect" class="navbar-brand text-white"> <i
                            class="fa fa-home"></i>홈
                    </a></li>
                </ul>
            </div>
        </div>
    </nav>
    <header id="main-header" class="py-2 bg-secondary"> </header>
    <section class="py-3 mb-3 bg-light">
        <div class="container">
            <div class="row col-md-12"></div>
        </div>
    </section>
    <section id="board">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="text-muted">
                                <i class="fas fa-sticky-note mr-sm-1"></i>글 내용
                            </h3>
                            <div class="form-group row">
                                <c:if
                                    test="${faqDTO.member_code == member_code || member_rating == 'admin'}">
                                    <div class="col-10 offset-2 pl-0 py-1">
                                        <a href="./FaqUpdate?faq_code=${faqDTO.faq_code}"
                                            class="btn btn-outline-secondary mr-1"> <i
                                            class="fas fa-edit"></i> 수정
                                        </a>
                                        <!-- 삭제 버튼에 onclick 이벤트 추가 -->
                                        <button onclick="deleteFaq(${faqDTO.faq_code})"
                                            class="btn btn-outline-danger">
                                            <i class="fas fa-trash"></i> 삭제
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row pl-1 pr-1">
                                <div class="col col-md-10">
                                    <input type="hidden" name="faq_code" value="${faqDTO.faq_code}">
                                    <div class="form-group row">
                                        <label for="subject" class="col-2 col-form-label pr-0"><i
                                            class="fas fa-pen-alt mr-sm-1"></i>제목</label>
                                        <div class="col-10 pl-0 py-1">${faqDTO.faq_title}</div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="question" class="col-2 col-form-label pr-0"><i
                                            class="fas fa-edit mr-sm-1"></i>내용</label>
                                        <div class="col-10 pl-0 py-1">${faqDTO.faq_question}</div>
                                    </div>
                                    <c:if
                                        test="${empty faqDTO.faq_answer and member_rating == 'admin'}">
                                        <div class="form-group row">
                                            <div class="col-12 text-right">
                                                <a href="./FaqAnswerUpdate?faq_code=${faqDTO.faq_code}"
                                                    class="btn btn-primary">댓글 작성</a>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty faqDTO.faq_answer}">
                                        <div class="form-group row">
                                            <label for="answer" class="col-2 col-form-label pr-0"><i
                                                class="fas fa-comments mr-sm-1"></i>답변</label>
                                            <div class="col-10 pl-0 py-1">
                                                ${faqDTO.faq_answer} <span class="text-muted ml-2">
                                                    작성일: <fmt:formatDate value="${faqDTO.faq_answer_date}"
                                                        pattern="yyyy-MM-dd HH:mm" /> <c:if
                                                        test="${member_rating == 'admin'}">
                                                        <a href="./FaqAnswerUpdate?faq_code=${faqDTO.faq_code}"
                                                            class="btn btn-outline-secondary btn-sm ml-2">수정</a>
                                                        <button onclick="deleteFaqAnswer(${faqDTO.faq_code})"
                                                            class="btn btn-outline-danger btn-sm ml-2">삭제</button>
                                                    </c:if>
                                                </span>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<footer id="main-footer" class="py-2 bg-secondary text-black">
    <div class="container">
        <div class="row align-items-start justify-content-between">
            <div class="col-md-8">
                <div>
                    <button onclick="location.href = './TermSelect'"
                            style="padding: 5px 10px; font-size: 15px; background-color: transparent; border: none; color: white;">
                        <i class="fa fa-user"></i> 이용약관
                    </button>
                </div>
            </div>
            <div class="col-md-4 text-right">
                <h1 style="font-size: 15px">
                    <i class="fas fa-lock"></i>e1i4 제작
                </h1>
            </div>
        </div>
    </div>
</footer>

</body>
</html>