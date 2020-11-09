package cn.lj.demo.controller;

import cn.lj.demo.bean.Parameter;
import cn.lj.demo.service.inter.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@Controller
//@RequestMapping(value = "/admin")
public class AdminController {
    @Resource
    private AdminService adminServiceImpl;

    @RequestMapping(value = "/adminLoginJsp")
    public String indexAdmin(){
        return "adminLogin";
    }

    @RequestMapping(value = "/backMainJsp")
    public String backMain(){
        return "backMain";
    }

    @RequestMapping(value = ("/adminLogin"))
    public void login(HttpServletResponse response, HttpServletRequest request,String loginAccount,String loginPassword) throws IOException {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 声明输出流，用该流将消息写给ajax
        PrintWriter out = response.getWriter();

        // 将数据传给Service,Service进行登录处理,之后将返回结果传给ajax
        Parameter admin = adminServiceImpl.login(loginAccount, loginPassword);
        System.out.println("============================================  :   "+admin);
        if(admin != null){
            // 登录成功
            request.getSession().setAttribute("adminAccount",admin.getPType());
            out.write("success");
        }else {
            // 登录失败
            out.write("fail");
        }
        // 刷新，防止缓冲区中还有数据为输出
        out.flush();
        out.close();
    }
}
