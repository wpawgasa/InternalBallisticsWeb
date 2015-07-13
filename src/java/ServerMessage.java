/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author wpawgasa
 */
public class ServerMessage {
    public String msg_name;
    public Boolean msg_status;
    public String msg_content;
    public String msg_debug;

    public ServerMessage() {
    }
    
    

    public String getMsg_name() {
        return msg_name;
    }

    public void setMsg_name(String msg_name) {
        this.msg_name = msg_name;
    }

    public Boolean getMsg_status() {
        return msg_status;
    }

    public void setMsg_status(Boolean msg_status) {
        this.msg_status = msg_status;
    }

    public String getMsg_content() {
        return msg_content;
    }

    public void setMsg_content(String msg_content) {
        this.msg_content = msg_content;
    }

    public String getMsg_debug() {
        return msg_debug;
    }

    public void setMsg_debug(String msg_debug) {
        this.msg_debug = msg_debug;
    }
    
    
    
}
