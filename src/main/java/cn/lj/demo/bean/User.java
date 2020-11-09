package cn.lj.demo.bean;

public class User {
    private int uId;
    private String account;
    private String password;
    private String uName;
    private String sex;
    private String education;
    private String profession;
    private String phone;
    private String email;
    private int integral;
    private String regTime;
    private int upLoads;
    private int downloadTimes;
    private int pId;// 有了parameter对象，pId就可以不要了
    private String pName;

    // 关联映射
    private Parameter parameter;//多表映射的第一步，在Java对象中表示表的一对多关系。第二步，定义一个xml映射文件,将实体类和表进行映射。第三步，测试。

    public User() {
    }

    public User(int uId, String account, String password, String uName, String sex, String education, String profession, String phone, String email, int integral, String regTime, int upLoads, int downloadTimes, int pId, String pName) {
        this.uId = uId;
        this.account = account;
        this.password = password;
        this.uName = uName;
        this.sex = sex;
        this.education = education;
        this.profession = profession;
        this.phone = phone;
        this.email = email;
        this.integral = integral;
        this.regTime = regTime;
        this.upLoads = upLoads;
        this.downloadTimes = downloadTimes;
        this.pId = pId;
        this.pName = pName;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getIntegral() {
        return integral;
    }

    public void setIntegral(int integral) {
        this.integral = integral;
    }

    public String getRegTime() {
        return regTime;
    }

    public void setRegTime(String regTime) {
        this.regTime = regTime;
    }

    public int getUpLoads() {
        return upLoads;
    }

    public void setUpLoads(int upLoads) {
        this.upLoads = upLoads;
    }

    public int getDownloadTimes() {
        return downloadTimes;
    }

    public void setDownloadTimes(int downloadTimes) {
        this.downloadTimes = downloadTimes;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }
}
