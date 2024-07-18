package parking.car.project.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.inject.Inject;
import parking.car.project.member.dto.MemberDTO;
import parking.car.project.member.entity.Member;
import parking.car.project.member.repository.MemberRepository;
import parking.car.project.member.service.MemberService;

@Controller
public class PageController {
    @Inject
    private MemberRepository memberRepository;
    
    @Inject
   private MemberService memberService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("members", memberRepository.findAll());
        return "index";
    }

    @GetMapping("/AdminSelect")
   public String list(Model model) {
      model.addAttribute("list", memberService.findAllMembers());
      return "member/admin/admin_select_view";
   }

    @GetMapping("/AdminSelectDetail")
    public String detail(Model model, @RequestParam("member_code") Integer member_code) {
        Member member = memberService.findMemberById(member_code);
        if (member != null) {
            MemberDTO memberDTO = new MemberDTO();
            memberDTO.setMember_code(member.getMember_code());
            memberDTO.setMember_id(member.getMember_id());
            memberDTO.setMember_name(member.getMember_name());
            memberDTO.setMember_password(member.getMember_password());
            memberDTO.setMember_email(member.getMember_email());
            memberDTO.setMember_callnumber(member.getMember_callnumber());
            memberDTO.setMember_birthday(member.getMember_birthday());
            memberDTO.setMember_gender(member.getMember_gender());
            memberDTO.setMember_joinday(member.getMember_joinday());
            memberDTO.setMember_car_num1(member.getMember_car_num1());
            memberDTO.setMember_car_num2(member.getMember_car_num2());
            memberDTO.setMember_car_num3(member.getMember_car_num3());
            memberDTO.setMember_rating(member.getMember_rating());
            model.addAttribute("memberDTO", memberDTO);
        }
        return "member/admin/admin_select_detail_view";
    }

    @GetMapping("/AdminView")
   public String admin(Model model) {
      return "member/admin/admin_view";
   }

    @GetMapping("/AdminUpdate")
    public String update(Model model, @RequestParam("member_code") Integer member_code) {
        Member member = memberService.findMemberById(member_code);
        if(member != null) {
            MemberDTO memberDTO = new MemberDTO();
            memberDTO.setMember_code(member.getMember_code());
            memberDTO.setMember_id(member.getMember_id());
            memberDTO.setMember_name(member.getMember_name());
            memberDTO.setMember_password(member.getMember_password());
            memberDTO.setMember_email(member.getMember_email());
            memberDTO.setMember_callnumber(member.getMember_callnumber());
            memberDTO.setMember_birthday(member.getMember_birthday());
            memberDTO.setMember_gender(member.getMember_gender());
            memberDTO.setMember_joinday(member.getMember_joinday());
            memberDTO.setMember_car_num1(member.getMember_car_num1());
            memberDTO.setMember_car_num2(member.getMember_car_num2());
            memberDTO.setMember_car_num3(member.getMember_car_num3());
            memberDTO.setMember_rating(member.getMember_rating());
            model.addAttribute("memberDTO", memberDTO);
        }
        return "member/admin/admin_update_view";
    }

    @GetMapping("/ManagerView")
   public String manager(Model model) {
      return "member/manager/manager_view";
   }
}
