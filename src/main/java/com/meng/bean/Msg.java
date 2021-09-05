package com.meng.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description
 * @Author Meng
 * @Versions
 * @Date 2021-05-12-21:14
 */
public class Msg {

    private int code;
    private String msg;
    private Map extend;



    public static Msg success(){

        Msg msg = new Msg();
        msg.code = 200;
        msg.msg = "操作成功";
        return msg;
    }

    public static Msg failure(){
        Msg msg = new Msg();
        msg.code=100;
        msg.msg = "操作失败";
        return msg;
    }

    public Msg add(String str,Object obj){
        this.extend = new HashMap();
        this.extend.put(str,obj);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map getExtend() {
        return extend;
    }

    public void setExtend(Map extend) {
        this.extend = extend;
    }
}
