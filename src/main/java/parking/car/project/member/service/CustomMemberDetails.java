package parking.car.project.member.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import parking.car.project.member.entity.Member;

import java.util.Collection;
import java.util.Collections;

public class CustomMemberDetails implements UserDetails {

    private final Member member;

    public CustomMemberDetails(Member member) {
        this.member = member;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + member.getMember_rating()));
    }

    @Override
    public String getPassword() {
        return "{noop}" + member.getMember_password(); // 비밀번호 인코딩 유지
    }

    @Override
    public String getUsername() {
        return member.getMember_id();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    // 추가 정보가 필요하면 getter 메소드를 추가
    public Integer getMemberCode() {
        return member.getMember_code();
    }

    public String getMemberRating() {
        return member.getMember_rating();
    }

    @Override
    public String toString() {
        return "CustomMemberDetails{" +
                "member_code=" + member.getMember_code() +
                ", member_id='" + member.getMember_id() + '\'' +
                ", member_rating='" + member.getMember_rating() + '\'' +
                '}';
    }
}
