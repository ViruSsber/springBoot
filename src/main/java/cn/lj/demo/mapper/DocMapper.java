package cn.lj.demo.mapper;



import cn.lj.demo.bean.Document;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface DocMapper {
    public List<Document> findAllDocument(Map<String, Object> conditionMap);
}
