
package com.tsd.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for userFailedInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="userFailedInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="account" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="authFailedCause" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="authFailedTime" type="{http://www.w3.org/2001/XMLSchema}anySimpleType" minOccurs="0"/>
 *         &lt;element name="nasGutter" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="nasIp" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nasPort" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="userGroupName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="userIp" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="userMac" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="userServiceName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="vlanId" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "userFailedInfo", propOrder = {
    "account",
    "authFailedCause",
    "authFailedTime",
    "nasGutter",
    "nasIp",
    "nasPort",
    "userGroupName",
    "userIp",
    "userMac",
    "userServiceName",
    "vlanId"
})
public class UserFailedInfo {

    protected String account;
    protected String authFailedCause;
    @XmlSchemaType(name = "anySimpleType")
    protected Object authFailedTime;
    protected int nasGutter;
    protected String nasIp;
    protected String nasPort;
    protected String userGroupName;
    protected String userIp;
    protected String userMac;
    protected String userServiceName;
    protected int vlanId;

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
     * Gets the value of the authFailedCause property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAuthFailedCause() {
        return authFailedCause;
    }

    /**
     * Sets the value of the authFailedCause property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAuthFailedCause(String value) {
        this.authFailedCause = value;
    }

    /**
     * Gets the value of the authFailedTime property.
     * 
     * @return
     *     possible object is
     *     {@link Object }
     *     
     */
    public Object getAuthFailedTime() {
        return authFailedTime;
    }

    /**
     * Sets the value of the authFailedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link Object }
     *     
     */
    public void setAuthFailedTime(Object value) {
        this.authFailedTime = value;
    }

    /**
     * Gets the value of the nasGutter property.
     * 
     */
    public int getNasGutter() {
        return nasGutter;
    }

    /**
     * Sets the value of the nasGutter property.
     * 
     */
    public void setNasGutter(int value) {
        this.nasGutter = value;
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
     * Gets the value of the userIp property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserIp() {
        return userIp;
    }

    /**
     * Sets the value of the userIp property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserIp(String value) {
        this.userIp = value;
    }

    /**
     * Gets the value of the userMac property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserMac() {
        return userMac;
    }

    /**
     * Sets the value of the userMac property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserMac(String value) {
        this.userMac = value;
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
     * Gets the value of the vlanId property.
     * 
     */
    public int getVlanId() {
        return vlanId;
    }

    /**
     * Sets the value of the vlanId property.
     * 
     */
    public void setVlanId(int value) {
        this.vlanId = value;
    }

}
