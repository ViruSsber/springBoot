package cn.lj.demo.service.inter;



import cn.lj.demo.bean.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    public User login(String account, String password);
    public int register(Map<String, String> map);
    public List<User> findAllUser(int page, int limit, String startTime, String endTime, String uName);
    public boolean delete(int uId);
}
