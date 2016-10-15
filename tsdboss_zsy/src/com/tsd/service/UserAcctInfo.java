
package com.tsd.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for userAcctInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="userAcctInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="groupName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="password" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="payType" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="portLimit" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="userAccount" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "userAcctInfo", propOrder = {
    "groupName",
    "password",
    "payType",
    "portLimit",
    "userAccount"
})
public class UserAcctInfo {

    protected String groupName;
    protected String password;
    protected int payType;
    protected int portLimit;
    protected String userAccount;

    public UserAcctInfo()
    {
    	
    }
    
    public UserAcctInfo(String userAccount,String password,
    		int portLimit,int payType
    		)
    {
    	this.payType=payType;
    	this.portLimit=portLimit;

    	this.password=password;
    	this.userAccount=userAccount;
    }
    /**
     * Gets the value of the groupName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupName() {
        return groupName;
    }

    /**
     * Sets the value of the groupName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupName(String value) {
        this.groupName = value;
    }

    /**
     * Gets the value of the password property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the value of the password property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPassword(String value) {
        this.password = value;
    }

    /**
     * Gets the value of the payType property.
     * 
     */
    public int getPayType() {
        return payType;
    }

    /**
     * Sets the value of the payType property.
     * 
     */
    public void setPayType(int value) {
        this.payType = value;
    }

    /**
     * Gets the value of the portLimit property.
     * 
     */
    public int getPortLimit() {
        return portLimit;
    }

    /**
     * Sets the value of the portLimit property.
     * 
     */
    public void setPortLimit(int value) {
        this.portLimit = value;
    }

    /**
     * Gets the value of the userAccount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserAccount() {
        return userAccount;
    }

    /**
     * Sets the value of the userAccount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserAccount(String value) {
        this.userAccount = value;
    }

}
