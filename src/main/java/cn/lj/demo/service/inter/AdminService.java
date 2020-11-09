package cn.lj.demo.service.inter;


import cn.lj.demo.bean.Parameter;

public interface AdminService {
    public Parameter login(String loginAccount, String loginPassword);
}
