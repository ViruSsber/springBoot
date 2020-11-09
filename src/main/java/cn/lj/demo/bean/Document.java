package cn.lj.demo.bean;

import org.springframework.stereotype.Component;

@Component
public class Document {

  private int dId;
  private String dName;
  private String dType;
  private String introduce;
  private String upTime;
  private String dState;
  private int docIntegral;
  private int downloadTimes;
  private int uId;
  private User user;

  public Document() {
  }

  public Document(int dId, String dName, String dType, String introduce, String upTime, String dState, int docIntegral, int downloadTimes, int uId, User user) {
    this.dId = dId;
    this.dName = dName;
    this.dType = dType;
    this.introduce = introduce;
    this.upTime = upTime;
    this.dState = dState;
    this.docIntegral = docIntegral;
    this.downloadTimes = downloadTimes;
    this.uId = uId;
    this.user = user;
  }

  public int getDId() {
    return dId;
  }

  public void setDId(int dId) {
    this.dId = dId;
  }


  public String getDName() {
    return dName;
  }

  public void setDName(String dName) {
    this.dName = dName;
  }


  public String getDType() {
    return dType;
  }

  public void setDType(String dType) {
    this.dType = dType;
  }


  public String getIntroduce() {
    return introduce;
  }

  public void setIntroduce(String introduce) {
    this.introduce = introduce;
  }


  public String getUpTime() {
    return upTime;
  }

  public void setUpTime(String upTime) {
    this.upTime = upTime;
  }


  public String getDState() {
    return dState;
  }

  public void setDState(String dState) {
    this.dState = dState;
  }


  public int getDocIntegral() {
    return docIntegral;
  }

  public void setDocIntegral(int docIntegral) {
    this.docIntegral = docIntegral;
  }


  public int getDownloadTimes() {
    return downloadTimes;
  }

  public void setDownloadTimes(int downloadTimes) {
    this.downloadTimes = downloadTimes;
  }


  public int getUId() {
    return uId;
  }

  public void setUId(int uId) {
    this.uId = uId;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }
}
