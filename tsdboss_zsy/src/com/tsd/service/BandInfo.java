
package com.tsd.service;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for bandInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="bandInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="bandType" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="ipBand" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="macBand" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nasBand" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="portBand" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="vlanBand" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "bandInfo", propOrder = {
    "bandType",
    "ipBand",
    "macBand",
    "nasBand",
    "portBand",
    "vlanBand"
})
public class BandInfo {

    protected int bandType;
    protected String ipBand;
    protected String macBand;
    protected String nasBand;
    protected String portBand;
    protected String vlanBand;

    /**
     * Gets the value of the bandType property.
     * 
     */
    public int getBandType() {
        return bandType;
    }

    /**
     * Sets the value of the bandType property.
     * 
     */
    public void setBandType(int value) {
        this.bandType = value;
    }

    /**
     * Gets the value of the ipBand property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIpBand() {
        return ipBand;
    }

    /**
     * Sets the value of the ipBand property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIpBand(String value) {
        this.ipBand = value;
    }

    /**
     * Gets the value of the macBand property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMacBand() {
        return macBand;
    }

    /**
     * Sets the value of the macBand property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMacBand(String value) {
        this.macBand = value;
    }

    /**
     * Gets the value of the nasBand property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNasBand() {
        return nasBand;
    }

    /**
     * Sets the value of the nasBand property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNasBand(String value) {
        this.nasBand = value;
    }

    /**
     * Gets the value of the portBand property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPortBand() {
        return portBand;
    }

    /**
     * Sets the value of the portBand property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPortBand(String value) {
        this.portBand = value;
    }

    /**
     * Gets the value of the vlanBand property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVlanBand() {
        return vlanBand;
    }

    /**
     * Sets the value of the vlanBand property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVlanBand(String value) {
        this.vlanBand = value;
    }

}
