package cn.lj.demo.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Configuration
public class LoginInterceptor implements HandlerInterceptor{
    private final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
    public static final String LAST_PAGE = "lastPage";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        logger.info("=============执行顺序1：preHandle===============");
        // 获取前端访问某个资源的网址：http://localhost:8080/B/backMainJsp
        String requestURI = request.getRequestURI();
        // 获取项目的上下文路径：/B
        String contextPath = request.getContextPath();
        // 获取所访问的资源的地址：/backMainJsp
        String url = requestURI.substring(contextPath.length());

        //访问的是登录页面和后台登录的方法，则放行
        if (url.equals("/adminLoginJsp") || url.equals("/adminLogin")){
            return true;
        }else {
            // 若未登录，则访问项目的任何资源，服务器都只会返回一个登录页面
            String adminAccount = (String) request.getSession().getAttribute("adminAccount");
            if(adminAccount == null){
                logger.info("");
                request.getRequestDispatcher("adminLoginJsp").forward(request,response);
                return false;
            }else {
                // 若已经登录，则放行
                return true;
            }
        }

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object o, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle");
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println("afterCompletion");
    }

    
}
