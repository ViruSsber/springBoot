package cn.lj.demo.utils;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;

public class MyBatisUtil {
    private static SqlSessionFactory sf=null;
    // get connection
    static{
        String config = "applicationContext.xml";
        Reader reader = null;
        try {
            reader = Resources.getResourceAsReader(config);
        } catch (IOException e) {
            e.printStackTrace();
        }

        SqlSessionFactoryBuilder sfb = new SqlSessionFactoryBuilder();
        sf = sfb.build(reader);

        getSession();
    }

    // get connection
    public static SqlSession getSession() {
        return sf.openSession();
    }

    // close  connection
    public static void closeSession(SqlSession session){
        if (session != null){
            session.close();
        }
    }

    public static int getint(){
        int a=10;
        try{
            System.out.println(a/0);
            a = 20;
        }catch (ArithmeticException e){
            a = 30;
            return a;
        }finally {
            a = 40;
            return a;
        }
    }

    public static void main(String[] args) {
//        System.out.println(MyBatisUtil.getSession());
//        Map<String,Object> map = new HashMap<>();
//        map.put("offset",1);
//        map.put("limit",10);
//        System.out.println(getSession().getMapper(UserMapper.class).findAllUser(map));

        System.out.println(getint());
    }
}
