package com.tsd.entity;

import java.util.Date;

/**
 * HthdangHz entity. @author MyEclipse Persistence Tools
 */

public class HthdangHz implements java.io.Serializable {

	// Fields

	private String hth;
	private String dh;
	private String yhmc;
	private String bm1;
	private String bm2;
	private String bm3;
	private String bm4;
	private String bmbh;
	private String yhxz;
	private String yhlb;
	private String sflx;
	private String area;
	private String yhdz;
	private String idcard;
	private String youbian;
	private int znjbz;
	private String delbz;
	private Date deldate;
	private String hthmfjb;
	private String hthdjjb;
	private String djhth;
	private int callpaytype;
	private int dhsl;
	private String hthmima;
	private String bz1;
	private String bz2;
	private String bz3;
	private String bz4;
	private String bz5;
	private String bz6;
	private String bz7;
	private String bz8;
	private String bz9;
	private String bz10;
	private int id;
	private int custtype;
	private int creditgrade;
	private String bossName;
	private String linktel;
	private String fixcode;
	private int tradetype;
	private int comptype;
	private String homepage;
	private String email;
	private String manageid;
	private int creditpoint;

	// Constructors

	/** default constructor */
	public HthdangHz() {
	}

	/** minimal constructor */
	public HthdangHz(String hth, int callpaytype, int dhsl) {
		this.hth = hth;
		this.callpaytype = callpaytype;
		this.dhsl = dhsl;
	}

	/** full constructor */
	public HthdangHz(String hth, String dh, String yhmc, String bm1,
			String bm2, String bm3, String bm4, String bmbh, String yhxz,
			String yhlb, String sflx, String area, String yhdz, String idcard,
			String youbian, int znjbz, String delbz, Date deldate,
			String hthmfjb, String hthdjjb, String djhth, int callpaytype,
			int dhsl, String hthmima, String bz1, String bz2, String bz3,
			String bz4, String bz5, String bz6, String bz7, String bz8,
			String bz9, String bz10, int id, int custtype, int creditgrade,
			String bossName, String linktel, String fixcode, int tradetype,
			int comptype, String homepage, String email, String manageid,
			int creditpoint) {
		this.hth = hth;
		this.dh = dh;
		this.yhmc = yhmc;
		this.bm1 = bm1;
		this.bm2 = bm2;
		this.bm3 = bm3;
		this.bm4 = bm4;
		this.bmbh = bmbh;
		this.yhxz = yhxz;
		this.yhlb = yhlb;
		this.sflx = sflx;
		this.area = area;
		this.yhdz = yhdz;
		this.idcard = idcard;
		this.youbian = youbian;
		this.znjbz = znjbz;
		this.delbz = delbz;
		this.deldate = deldate;
		this.hthmfjb = hthmfjb;
		this.hthdjjb = hthdjjb;
		this.djhth = djhth;
		this.callpaytype = callpaytype;
		this.dhsl = dhsl;
		this.hthmima = hthmima;
		this.bz1 = bz1;
		this.bz2 = bz2;
		this.bz3 = bz3;
		this.bz4 = bz4;
		this.bz5 = bz5;
		this.bz6 = bz6;
		this.bz7 = bz7;
		this.bz8 = bz8;
		this.bz9 = bz9;
		this.bz10 = bz10;
		this.id = id;
		this.custtype = custtype;
		this.creditgrade = creditgrade;
		this.bossName = bossName;
		this.linktel = linktel;
		this.fixcode = fixcode;
		this.tradetype = tradetype;
		this.comptype = comptype;
		this.homepage = homepage;
		this.email = email;
		this.manageid = manageid;
		this.creditpoint = creditpoint;
	}

	// Property accessors

	public String getHth() {
		return this.hth;
	}

	public void setHth(String hth) {
		this.hth = hth;
	}

	public String getDh() {
		return this.dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public String getYhmc() {
		return this.yhmc;
	}

	public void setYhmc(String yhmc) {
		this.yhmc = yhmc;
	}

	public String getBm1() {
		return this.bm1;
	}

	public void setBm1(String bm1) {
		this.bm1 = bm1;
	}

	public String getBm2() {
		return this.bm2;
	}

	public void setBm2(String bm2) {
		this.bm2 = bm2;
	}

	public String getBm3() {
		return this.bm3;
	}

	public void setBm3(String bm3) {
		this.bm3 = bm3;
	}

	public String getBm4() {
		return this.bm4;
	}

	public void setBm4(String bm4) {
		this.bm4 = bm4;
	}

	public String getBmbh() {
		return this.bmbh;
	}

	public void setBmbh(String bmbh) {
		this.bmbh = bmbh;
	}

	public String getYhxz() {
		return this.yhxz;
	}

	public void setYhxz(String yhxz) {
		this.yhxz = yhxz;
	}

	public String getYhlb() {
		return this.yhlb;
	}

	public void setYhlb(String yhlb) {
		this.yhlb = yhlb;
	}

	public String getSflx() {
		return this.sflx;
	}

	public void setSflx(String sflx) {
		this.sflx = sflx;
	}

	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getYhdz() {
		return this.yhdz;
	}

	public void setYhdz(String yhdz) {
		this.yhdz = yhdz;
	}

	public String getIdcard() {
		return this.idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getYoubian() {
		return this.youbian;
	}

	public void setYoubian(String youbian) {
		this.youbian = youbian;
	}

	public int getZnjbz() {
		return this.znjbz;
	}

	public void setZnjbz(int znjbz) {
		this.znjbz = znjbz;
	}

	public String getDelbz() {
		return this.delbz;
	}

	public void setDelbz(String delbz) {
		this.delbz = delbz;
	}

	public Date getDeldate() {
		return this.deldate;
	}

	public void setDeldate(Date deldate) {
		this.deldate = deldate;
	}

	public String getHthmfjb() {
		return this.hthmfjb;
	}

	public void setHthmfjb(String hthmfjb) {
		this.hthmfjb = hthmfjb;
	}

	public String getHthdjjb() {
		return this.hthdjjb;
	}

	public void setHthdjjb(String hthdjjb) {
		this.hthdjjb = hthdjjb;
	}

	public String getDjhth() {
		return this.djhth;
	}

	public void setDjhth(String djhth) {
		this.djhth = djhth;
	}

	public int getCallpaytype() {
		return this.callpaytype;
	}

	public void setCallpaytype(int callpaytype) {
		this.callpaytype = callpaytype;
	}

	public int getDhsl() {
		return this.dhsl;
	}

	public void setDhsl(int dhsl) {
		this.dhsl = dhsl;
	}

	public String getHthmima() {
		return this.hthmima;
	}

	public void setHthmima(String hthmima) {
		this.hthmima = hthmima;
	}

	public String getBz1() {
		return this.bz1;
	}

	public void setBz1(String bz1) {
		this.bz1 = bz1;
	}

	public String getBz2() {
		return this.bz2;
	}

	public void setBz2(String bz2) {
		this.bz2 = bz2;
	}

	public String getBz3() {
		return this.bz3;
	}

	public void setBz3(String bz3) {
		this.bz3 = bz3;
	}

	public String getBz4() {
		return this.bz4;
	}

	public void setBz4(String bz4) {
		this.bz4 = bz4;
	}

	public String getBz5() {
		return this.bz5;
	}

	public void setBz5(String bz5) {
		this.bz5 = bz5;
	}

	public String getBz6() {
		return this.bz6;
	}

	public void setBz6(String bz6) {
		this.bz6 = bz6;
	}

	public String getBz7() {
		return this.bz7;
	}

	public void setBz7(String bz7) {
		this.bz7 = bz7;
	}

	public String getBz8() {
		return this.bz8;
	}

	public void setBz8(String bz8) {
		this.bz8 = bz8;
	}

	public String getBz9() {
		return this.bz9;
	}

	public void setBz9(String bz9) {
		this.bz9 = bz9;
	}

	public String getBz10() {
		return this.bz10;
	}

	public void setBz10(String bz10) {
		this.bz10 = bz10;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCusttype() {
		return this.custtype;
	}

	public void setCusttype(int custtype) {
		this.custtype = custtype;
	}

	public int getCreditgrade() {
		return this.creditgrade;
	}

	public void setCreditgrade(int creditgrade) {
		this.creditgrade = creditgrade;
	}

	public String getBossName() {
		return this.bossName;
	}

	public void setBossName(String bossName) {
		this.bossName = bossName;
	}

	public String getLinktel() {
		return this.linktel;
	}

	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}

	public String getFixcode() {
		return this.fixcode;
	}

	public void setFixcode(String fixcode) {
		this.fixcode = fixcode;
	}

	public int getTradetype() {
		return this.tradetype;
	}

	public void setTradetype(int tradetype) {
		this.tradetype = tradetype;
	}

	public int getComptype() {
		return this.comptype;
	}

	public void setComptype(int comptype) {
		this.comptype = comptype;
	}

	public String getHomepage() {
		return this.homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getManageid() {
		return this.manageid;
	}

	public void setManageid(String manageid) {
		this.manageid = manageid;
	}

	public int getCreditpoint() {
		return this.creditpoint;
	}

	public void setCreditpoint(int creditpoint) {
		this.creditpoint = creditpoint;
	}

	@Override
	public String toString() {
		return "HthdangHz [hth=" + hth + ", dh=" + dh + ", yhmc=" + yhmc
				+ ", bm1=" + bm1 + ", bm2=" + bm2 + ", bm3=" + bm3 + ", bm4="
				+ bm4 + ", bmbh=" + bmbh + ", yhxz=" + yhxz + ", yhlb=" + yhlb
				+ ", sflx=" + sflx + ", area=" + area + ", yhdz=" + yhdz
				+ ", idcard=" + idcard + ", youbian=" + youbian + ", znjbz="
				+ znjbz + ", delbz=" + delbz + ", deldate=" + deldate
				+ ", hthmfjb=" + hthmfjb + ", hthdjjb=" + hthdjjb + ", djhth="
				+ djhth + ", callpaytype=" + callpaytype + ", dhsl=" + dhsl
				+ ", hthmima=" + hthmima + ", bz1=" + bz1 + ", bz2=" + bz2
				+ ", bz3=" + bz3 + ", bz4=" + bz4 + ", bz5=" + bz5 + ", bz6="
				+ bz6 + ", bz7=" + bz7 + ", bz8=" + bz8 + ", bz9=" + bz9
				+ ", bz10=" + bz10 + ", id=" + id + ", custtype=" + custtype
				+ ", creditgrade=" + creditgrade + ", bossName=" + bossName
				+ ", linktel=" + linktel + ", fixcode=" + fixcode
				+ ", tradetype=" + tradetype + ", comptype=" + comptype
				+ ", homepage=" + homepage + ", email=" + email + ", manageid="
				+ manageid + ", creditpoint=" + creditpoint + "]";
	}

}