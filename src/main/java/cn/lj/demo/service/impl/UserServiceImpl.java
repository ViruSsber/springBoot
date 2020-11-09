package cn.lj.demo.service.impl;

import cn.lj.demo.bean.User;
import cn.lj.demo.mapper.UserMapper;
import cn.lj.demo.service.inter.UserService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;
    @Override
    public User login(String account, String password) {

        Map map = new HashMap<String,Integer>();
        map.put("loginAccount",account);
        map.put("loginPassword",password);
        User user = userMapper.login(map);
        return user;
    }

    @Override
    public int register(Map<String, String> map) {

        int result = 0;

        // 检查账号是否已被注册，若没有，则执行插入操作
        if (userMapper.checkAccount(map)==null){
            result = userMapper.register(map);
        }else{
            return -1;
        }

        return result;
    }

    @Override
    public List<User> findAllUser(int page,int limit,String startTime,String endTime,String uName) {
        // 处理搜索条件
        Map<String,Object> conditionMap = new HashMap<>();
        if (startTime != null && !startTime.trim().equals("")){
            conditionMap.put("startTime",startTime);
        }
        if (endTime != null && !endTime.trim().equals("")){
            conditionMap.put("endTime",endTime);
        }
        if (uName != null && !uName.trim().equals("")){
            conditionMap.put("uName",uName);
        }


        conditionMap.put("offset",(page-1)*limit);
        conditionMap.put("limit",limit);
        return userMapper.findAllUser(conditionMap);
    }

    @Override
    public boolean delete(int uId){
//        UserDao userDao = (UserDao) ObjectFactory.getInstance("cn.itcast.dao.UserDao");
//        return userDao.delete(uId);
        return false;
    }
}
