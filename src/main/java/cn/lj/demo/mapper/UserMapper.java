package cn.lj.demo.mapper;


import cn.lj.demo.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface UserMapper {
    //带参方式一,需要配置parameterType="java.util.HashMap"
    public List<User> findAllUser(Map<String, Object> map);
    //带参方式二，参数少时可以直接通过注解传参，参数多时要封装一下,此时parameterType="cn.lj.bean.User"
//    public List<User> findAllUser(@Param("offset") Integer offset,@Param("limit") Integer limit);

    public void delUsers(List<String> ids) ;
    public User login(Map<String, String> map);
    public User checkAccount(Map<String, String> map);
    public int register(Map<String, String> map);
}
