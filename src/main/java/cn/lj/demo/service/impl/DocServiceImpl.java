package cn.lj.demo.service.impl;


import cn.lj.demo.bean.Document;
import cn.lj.demo.mapper.DocMapper;
import cn.lj.demo.service.inter.DocService;
import org.springframework.stereotype.Service;


import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class DocServiceImpl implements DocService {
    @Resource
    private DocMapper docMapper;

    @Override
    public List<Document> findAllDocument(Map<String, Object> conditionMap) {
        List<Document>  allDocument= docMapper.findAllDocument(conditionMap);
        return allDocument;
    }
}
