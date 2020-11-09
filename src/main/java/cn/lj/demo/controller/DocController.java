package cn.lj.demo.controller;

import cn.lj.demo.bean.Document;
import cn.lj.demo.bean.TableInfo;
import cn.lj.demo.service.inter.DocService;
import com.google.gson.Gson;
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
//@RequestMapping(value = "/doc")
public class DocController {
    @Resource
    private DocService docServiceImpl;

    @RequestMapping(value = "/docJsp")
    public String docJsp(){
        return "docManage";
    }

    @RequestMapping(value = "/docList")
    public void getDocListByCondition(HttpServletRequest request, HttpServletResponse response,String parameterName, String dName, String uName, String dType, String startTime, String endTime, String page, String limit) throws IOException {
        // 设置数据传给前台时的编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        switch (parameterName){
            case "findAllDoc":
                int pageInt = 0;
                int limitInt = 0;

                if (page!=null && !page.trim().equals("")){
                    pageInt = Integer.parseInt(page);
                }

                if (limit!=null && !limit.trim().equals("")){
                    limitInt = Integer.parseInt(limit);
                }


                System.out.println(dName);
                System.out.println(uName);
                System.out.println(dType);
                System.out.println(startTime);
                System.out.println(endTime);


                // 将上面获取到的数据放在Map中
                Map<String, Object> conditionMap = new HashMap<>();
                conditionMap.put("offset",(pageInt-1)*limitInt);
                conditionMap.put("limit",limitInt);
                if (dName != null && !dName.trim().equals("")){
                    conditionMap.put("dName",dName);
                }
                if (uName != null && !uName.trim().equals("")){
                    conditionMap.put("uName",uName);
                }
                if (dType != null && !dType.trim().equals("")){
                    conditionMap.put("dType",dType);
                }
                if (startTime != null && !startTime.trim().equals("")){
                    conditionMap.put("startTime",startTime);
                }
                if (endTime != null && !endTime.trim().equals("")){
                    conditionMap.put("endTime",endTime);
                }

                // 将参数传给service层进行业务处理
                List<Document> list = docServiceImpl.findAllDocument(conditionMap);

                // 将数据封装成前台table.render中需要的格式
                TableInfo tableInfo = new TableInfo(0,"文档列表数据",2000,list);

                // 前台指定后台必须发送JSON数据，故将结果封装成JSON数据
                String jsonData = new Gson().toJson(tableInfo);

                // 将JSON数据发送给前台
                PrintWriter out = response.getWriter();
                out.write(jsonData);
                out.flush();
                out.close();
                break;
        }
    }
}
