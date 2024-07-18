package parking.car.project.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import parking.car.project.member.service.CustomMemberDetailsService;

@Controller
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    private final CustomMemberDetailsService customMemberDetailsService;

    @Inject
    public LoginController(CustomMemberDetailsService customMemberDetailsService) {
        this.customMemberDetailsService = customMemberDetailsService;
    }

    @GetMapping("/login")
    public String login() {
        return "member/login"; // login.jsp 페이지로 이동
    }

    @PostMapping("/login_proc")
    public String loginProcess(@RequestParam("username") String username, @RequestParam("password") String password,
                               HttpServletRequest request, HttpSession session) { // HttpServletRequest 및 HttpSession 추가
        logger.debug("로그인 시도 - 사용자: {}", username);
        UserDetails userDetails = customMemberDetailsService.loadUserByUsername(username);
        if (userDetails != null && ("{noop}" + password).equals(userDetails.getPassword())) {
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                    userDetails, null, userDetails.getAuthorities());
            authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request)); // request 사용
            SecurityContextHolder.getContext().setAuthentication(authenticationToken); // 인증 정보 설정
            session.setAttribute("customMemberDetails", userDetails); // 세션에 사용자 정보 저장
            logger.debug("로그인 성공 - 사용자: {}", username);
            logger.debug("세션 정보 - 사용자 이름: {}", userDetails.getUsername());
            logger.debug("세션 정보 - 권한: {}", userDetails.getAuthorities());
            logger.debug("세션 정보 - 사용자 상세: {}", userDetails);
            return "redirect:/"; // 로그인 성공 시 리다이렉트
        } else {
            logger.debug("로그인 실패 - 사용자: {}", username);
            return "redirect:/login?error=true"; // 로그인 실패 시 리다이렉트
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpSession session) {
        SecurityContextHolder.clearContext(); // SecurityContextHolder를 통해 인증 정보를 삭제
        session.invalidate(); // 세션 무효화
        return "redirect:/"; // 로그아웃 후 인덱스 페이지로 리다이렉트
    }
}
