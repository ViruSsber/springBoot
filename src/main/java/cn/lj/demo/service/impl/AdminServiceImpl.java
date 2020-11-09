package cn.lj.demo.service.impl;


import cn.lj.demo.bean.Parameter;
import cn.lj.demo.mapper.AdminMapper;
import cn.lj.demo.service.inter.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {
    @Resource
    private AdminMapper adminMapper;

    @Override
    public Parameter login(String loginAccount, String loginPassword) {
        Map<String,String> map = new HashMap<>();
        map.put("loginAccount",loginAccount);
        map.put("loginPassword",loginPassword);
        return adminMapper.login(map);
    }
}
