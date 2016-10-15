
package com.tsd.service;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for retUserOnlineInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="retUserOnlineInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="count" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="userOnlineInfo" type="{http://service.tsd.com/}userOnlineInfo" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "retUserOnlineInfo", propOrder = {
    "count",
    "userOnlineInfo"
})
public class RetUserOnlineInfo {

    protected int count;
    @XmlElement(nillable = true)
    protected List<UserOnlineInfo> userOnlineInfo;
    
    public RetUserOnlineInfo()
    {
    	
    }
    
    public RetUserOnlineInfo(int count,List<UserOnlineInfo> userOnlineInfo)
    {
    	this.count=count;
    	this.userOnlineInfo=userOnlineInfo;
    }
    
    /**
     * Gets the value of the count property.
     * 
     */
    public int getCount() {
        return count;
    }

    /**
     * Sets the value of the count property.
     * 
     */
    public void setCount(int value) {
        this.count = value;
    }

    /**
     * Gets the value of the userOnlineInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the userOnlineInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getUserOnlineInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link UserOnlineInfo }
     * 
     * 
     */
    public List<UserOnlineInfo> getUserOnlineInfo() {
        if (userOnlineInfo == null) {
            userOnlineInfo = new ArrayList<UserOnlineInfo>();
        }
        return this.userOnlineInfo;
    }

	public void setUserOnlineInfo(List<UserOnlineInfo> userOnlineInfo) {
		this.userOnlineInfo = userOnlineInfo;
	}

}
