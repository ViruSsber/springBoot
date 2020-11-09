package cn.lj.demo.mapper;

import cn.lj.demo.bean.Parameter;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import java.util.Map;

@Repository
@Mapper
public interface AdminMapper {
    public Parameter login(Map<String, String> map);
}
