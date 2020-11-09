package cn.lj.demo.service.inter;



import cn.lj.demo.bean.Document;

import java.util.List;
import java.util.Map;

public interface DocService {
    public List<Document> findAllDocument(Map<String, Object> conditionMap);
}
