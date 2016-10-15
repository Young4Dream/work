
package com.tsd.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

import org.json.JSONException;
import org.json.JSONStringer;


/**
 * <p>Java class for resultInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="resultInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="infoNo" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="infoStr" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "resultInfo", propOrder = {
    "infoNo",
    "infoStr"
})
public class ResultInfo implements org.json.JSONString, java.io.Serializable{


	private static final long serialVersionUID = 1L;
	protected int infoNo;
    protected String infoStr;
    
	/**
	 * 构造方法，实例化一个消息信息类
	 */
    public ResultInfo()
    {
    	
    }

	/**
	 * 获取消息编号，当调用接口失败时，可以从该属性中得到错误编号
	 * 
	 * @return 消息编号
	 */
    public int getInfoNo() {
        return infoNo;
    }

	/**
	 * 设置消息编号
	 * 
	 * @param infoNo
	 *            消息编号，选填
	 */
    public void setInfoNo(int value) {
        this.infoNo = value;
    }

	/**
	 * 获取消息，当调用接口失败时，可以从该属性中得到错误原因
	 * 
	 * @return 消息
	 */
    public String getInfoStr() {
        return infoStr;
    }

	/**
	 * 设置消息
	 * 
	 * @param infoStr
	 *            消息，选填
	 */
    public void setInfoStr(String value) {
        this.infoStr = value;
    }
    
    /**
     *转换json格式，便于页面显示
     * @return
     */
    public String toJSONString() {
		try {
			return new JSONStringer().object().key("infoNo").value(infoNo).key(
					"infoStr").value(infoStr).endObject().toString();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return null;
	}

}
