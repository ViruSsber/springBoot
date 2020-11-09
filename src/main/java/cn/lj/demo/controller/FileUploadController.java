package cn.lj.demo.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Controller
//@RequestMapping("/file")
public class FileUploadController {

    @RequestMapping("/downloadJsp")
    public String getFileJsp(){
        return "downloadDoc";
    }

    @RequestMapping("/fileAct")
    public String upload(@RequestParam("imgFile") MultipartFile imgFile, String uName, HttpServletRequest request){
        // 获取上传的目录路径，即保存文件的目录 ---- /target//upload
//        String path = request.getSession().getServletContext().getRealPath("/upload");
        String path = "F://FileSave";
        // 获取上传时的日期，以日期划分文件
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        // 创建目录或者子目录
        File file = new File(path,date);
        if (!file.exists()){
            file.mkdirs();
        }
        // 获取原始文件名
        String fileName = imgFile.getOriginalFilename();
        //重新命名文件名，以UUID的数据格式命名文件
//        fileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
        System.out.println(fileName);

        // 通过MultipartFile中的transferTo方法上传文件
        try {
            imgFile.transferTo(new File(file,fileName));

            // 将文件信息写入数据库

        } catch (IOException e) {
            e.printStackTrace();
            return "false";
        }
        return "success";
    }

    /*
     * Spring 框架技术下载文件
     */
    @RequestMapping(value = "/download",method = RequestMethod.GET)
    public ResponseEntity<byte[]> download (HttpServletRequest request,String fileName) throws IOException {
        //获取下载文件的真实路径(从数据中获取，根据dId)
        String realPath = request.getServletContext().getRealPath("/upload");
        realPath = realPath+"\\2020-11-02\\";
        //把下载文件构成一个文件处理，fileName：前台传过来的文件名称
        System.out.println(realPath);
        File file = new File(realPath,fileName);
        System.out.println(file.getAbsoluteFile());
        //设置头信息
        HttpHeaders headers = new HttpHeaders();
        String downloadFileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
        // 设置响应的文件名
        headers.setContentDispositionFormData("attachment",downloadFileName);
        // MediaType：互联网媒介类型，contextType：具体请求中的媒体类型信息
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);
    }
}
