package cn.lj.demo.utils;

public class ObjectFactory {
    public static  Object getInstance(String classPath){
        Object obj = null;
        try {
            Class clazz = Class.forName(classPath);
            obj = clazz.newInstance();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        }

        return obj;
    }
}
