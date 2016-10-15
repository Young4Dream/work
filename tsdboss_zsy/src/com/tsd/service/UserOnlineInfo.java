
package com.tsd.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * <p>Java class for userOnlineInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="userOnlineInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="accessTime" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/>
 *         &lt;element name="account" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="clientIp" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="clientMac" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nasIp" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nasPort" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nasPortType" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="userGroupName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="userServiceName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="vlan" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "userOnlineInfo", propOrder = {
    "accessTime",
    "account",
    "clientIp",
    "clientMac",
    "nasIp",
    "nasPort",
    "nasPortType",
    "userGroupName",
    "userServiceName",
    "vlan"
})
public class UserOnlineInfo {

    protected XMLGregorianCalendar accessTime;
    protected String account;
    protected String clientIp;
    protected String clientMac;
    protected String nasIp;
    protected String nasPort;
    protected String nasPortType;
    protected String userGroupName;
    protected String userServiceName;
    protected String vlan;
    
    public UserOnlineInfo()
    {
    	
    }
    
   

    /**
     * Gets the value of the accessTime property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getAccessTime() {
        return accessTime;
    }

    /**
     * Sets the value of the accessTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setAccessTime(XMLGregorianCalendar value) {
        this.accessTime = value;
    }

    /**
     * Gets the value of the account property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccount() {
        return account;
    }

    /**
     * Sets the value of the account property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccount(String value) {
        this.account = value;
    }

    /**
     * Gets the value of the clientIp property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClientIp() {
        return clientIp;
    }

    /**
     * Sets the value of the clientIp property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClientIp(String value) {
        this.clientIp = value;
    }

    /**
     * Gets the value of the clientMac property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClientMac() {
        return clientMac;
    }

    /**
     * Sets the value of the clientMac property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClientMac(String value) {
        this.clientMac = value;
    }

    /**
     * Gets the value of the nasIp property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNasIp() {
        return nasIp;
    }

    /**
     * Sets the value of the nasIp property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNasIp(String value) {
        this.nasIp = value;
    }

    /**
     * Gets the value of the nasPort property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNasPort() {
        return nasPort;
    }

    /**
     * Sets the value of the nasPort property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNasPort(String value) {
        this.nasPort = value;
    }

    /**
     * Gets the value of the nasPortType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNasPortType() {
        return nasPortType;
    }

    /**
     * Sets the value of the nasPortType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNasPortType(String value) {
        this.nasPortType = value;
    }

    /**
     * Gets the value of the userGroupName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserGroupName() {
        return userGroupName;
    }

    /**
     * Sets the value of the userGroupName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserGroupName(String value) {
        this.userGroupName = value;
    }

    /**
     * Gets the value of the userServiceName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserServiceName() {
        return userServiceName;
    }

    /**
     * Sets the value of the userServiceName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserServiceName(String value) {
        this.userServiceName = value;
    }

    /**
     * Gets the value of the vlan property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVlan() {
        return vlan;
    }

    /**
     * Sets the value of the vlan property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVlan(String value) {
        this.vlan = value;
    }

}
