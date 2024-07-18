<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 입력</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
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
    function confirmSignUp(event) {
        event.preventDefault(); // 폼 제출 기본 동작을 막음

        if (confirm("회원가입 하시겠습니까?")) {
            document.getElementById("sign_member").submit(); // 폼 제출

            // 회원가입 완료 팝업을 띄우기 위해 약간의 딜레이를 줍니다.
            setTimeout(function() {
                alert("회원가입이 완료되었습니다.");
            }, 100);
        }
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("sign_member").addEventListener("submit", confirmSignUp);
    });
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
         </div>
      </div>
   </header>

<main>

	<header id="main-header" class="py-2 btn-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>회원 정보 입력</h1>
				</div>
			</div>
		</div>
	</header>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h5>회원 입력</h5>
					</div>
					<div class="card-body">
						<form id="sign_member" method="post">
							<fieldset>
								<div class="form-group row">
									<label for="member_id" class="ml-sm-3 col-form-label">
										회원 아이디 </label>
									<div class="ml-sm-3">
										<input type="text" name="member_id" id="member_id"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_name" class="ml-sm-3 col-form-label">
										회원 이름 </label>
									<div class="ml-sm-3">
										<input type="text" name="member_name" id="member_name"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_password" class="ml-sm-3 col-form-label">
										회원 비밀번호 </label>
									<div class="ml-sm-3">
										<input type="password" name="member_password" id="member_password"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_email" class="ml-sm-3 col-form-label">
										회원 이메일 </label>
									<div class="ml-sm-3">
										<input type="email" name="member_email" id="member_email"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_callnumber" class="ml-sm-3 col-form-label">
										회원 전화번호 </label>
									<div class="ml-sm-3">
										<input type="text" name="member_callnumber" id="member_callnumber"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_birthday" class="ml-sm-3 col-form-label">
										회원 생년월일 </label>
									<div class="ml-sm-3">
										<input type="date" name="member_birthday" id="member_birthday"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_gender" class="ml-sm-3 col-form-label">
										회원 성별 </label>
									<div class="ml-sm-3">
										<select name="member_gender" id="member_gender"
											class="form-control form-control-sm">
											<option value="" disabled selected>선택</option>
											<option value="male">남자</option>
											<option value="female">여자</option>
										</select>
									</div>
								</div>

								<div class="form-group row">
									<label for="member_car_num1" class="ml-sm-3 col-form-label">
										회원 차번호1 </label>
									<div class="ml-sm-3">
										<input type="text" name="member_car_num1" id="member_car_num1"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_car_num2" class="ml-sm-3 col-form-label">
										회원 차번호2 </label>
									<div class="ml-sm-3">
										<input type="text" name="member_car_num2" id="member_car_num2"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group row">
									<label for="member_car_num3" class="ml-sm-3 col-form-label">
										회원 차번호3 </label>
									<div class="ml-sm-3">
										<input type="text" name="member_car_num3" id="member_car_num3"
											class="form-control form-control-sm">
									</div>
								</div>

								<div class="form-group">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<button type="submit" class="btn btn-secondary">회원 가입</button>
									<button type="reset" class="btn btn-secondary">취소</button>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

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
