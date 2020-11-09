package cn.lj.demo.controller;

import cn.lj.demo.bean.TableInfo;
import cn.lj.demo.bean.User;
import cn.lj.demo.service.inter.UserService;
import com.google.gson.Gson;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
//@RequestMapping(value = "/user")
public class UserController {
    @Resource
    private UserService userServiceImpl;

    @RequestMapping(value = "/userLoginJsp")
    public String indexUser(){
        return "userLogin";
    }

    @RequestMapping(value = ("/userLogin"))
    public void login(HttpServletRequest request,HttpServletResponse response, String loginUsername, String loginPassword) throws IOException {
//        UserService userService = (UserService) ObjectFactory.getInstance("cn.lj.service.impl.UserServiceImpl");

        PrintWriter out = response.getWriter();
        User user = userServiceImpl.login(loginUsername, loginPassword);
        if (user != null){
            request.getSession().setAttribute("uId",user.getuId());
            out.write("success");
        }else {
            out.write("fail");
        }
        out.flush();
        out.close();
    }

    @RequestMapping(value = ("/userRegister"))
    public void register(HttpServletResponse response,HttpServletRequest request, User user) throws IOException {
        // 设置编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 获取参数并进行封装
        Map<String, String> map = new HashMap<>();

        map.put("registerUsername",user.getuName());
        map.put("registerAccount",user.getAccount());
        map.put("registerPassword",user.getPassword());
        map.put("registerSex",user.getSex());
        map.put("registerEducation",user.getEducation());
        map.put("registerProfession",user.getProfession());
        map.put("registerPhone",user.getPhone());
        map.put("registerEmail",user.getEmail());
        map.put("registerTime",user.getRegTime());

        // 将数据传给Service,Service进行注册处理,之后将返回结果传给ajax
        int result = userServiceImpl.register(map);

        // 声明输出流，用该流将消息写给ajax
        PrintWriter out = response.getWriter();
        if (result>0){
            // 注册成功
            out.write("success");
        }else if (result == 0){
            // 注册失败
            out.write("fail");
        }else {
            // 账号已被注册
            out.write("illegal");
        }
        // 刷新，防止缓冲区中还有数据为输出
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/userQueryJsp")
    public String userQuery(){
        return "userQuery";
    }

    @RequestMapping(value = "/userQuery")
    public void findAllUser(HttpServletResponse response, HttpServletRequest request, String page, String limit, String startTime, String endTime, String uName) throws UnsupportedEncodingException {
        // 设置数据传给前台时的编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int pageInt = 0;
        int limitInt = 0;

        if (page!=null && !page.trim().equals("")){
            pageInt = Integer.parseInt(page);
        }

        if (limit!=null && !limit.trim().equals("")){
            limitInt = Integer.parseInt(limit);
        }

        System.out.println("page: "+pageInt+"   limit: "+limitInt+"   uName: "+uName+"   startTime: "+startTime+"    endTime: "+endTime);

        // 将数据传递给Servic层，进行查询用户列表的业务处理
        List<User> list = userServiceImpl.findAllUser(pageInt,limitInt,startTime,endTime,uName);

        // 将数据封装成前台table.render中需要的格式
        TableInfo tableInfo = new TableInfo(0,"用户列表数据",2000,list);

        // 前台指定后台必须发送JSON数据，故封装JSON数据
        String jsonData = new Gson().toJson(tableInfo);

        // 将JSON数据发送给前台
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.write(jsonData);
        out.flush();
        out.close();
    }
}


