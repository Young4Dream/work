package com.tsd.entity;

import java.util.Date;

/**
 * Teljob entity. @author MyEclipse Persistence Tools
 */

public class Teljob_bak implements java.io.Serializable {

	// Fields

	private long id;
	private String lsh;
	private String cardid;
	private String xdh;
	private String ydh;
	private String area;
	private String beginywarea;
	private String ywarea;
	private String hth;
	private String yhth;
	private long typeid;
	private long idd;
	private String sgnr;
	private String bz;
	private Date sgrq;
	private String dhlx;
	private String jlry;
	private String xm;
	private String nxm;
	private String bm1;
	private String bm2;
	private String bm3;
	private String bm4;
	private String yhxz;
	private String zw;
	private String xdz;
	private String ydz;
	private String zjlx;
	private String dhgn;
	private String linkman;
	private String lxdh;
	private String gzlx;
	private String wxbz;
	private String wxry;
	private String yjkx;
	private double yjje;
	private String slbm;
	private String ispay;
	private Date pgrq;
	private String mqbm;
	private String jsbm;
	private String pxggbj;
	private String chggbj;
	private String jfggbj;
	private String pgrz;
	private Date wgrq;
	private String wgbm;
	private String iscomplete;
	private String modual;
	private String port;
	private String typenum;
	private double sjje;
	private String payFlag;
	private String value1;
	private String value2;
	private String value3;
	private String value4;
	private String value5;
	private String value6;
	private String value7;
	private String value8;
	private String value9;
	private String value10;
	private String value11;
	private String value12;
	private String value13;
	private String value14;
	private String value15;
	private String value16;
	private String value17;
	private String value18;
	private String value19;
	private String value20;
	private String ifcancel;
	private String isjudge;
	private Date djhwcsj;
	private Date djhswc;
	private String mobile;
	private String jiaofeidh;
	private String jobstatus;
	private String ifurgent;
	private int reprinttimesofsf;
	private int reprinttimesofjob;
	private String zwbz;

	// Constructors

	/** default constructor */
	public Teljob_bak() {
	}

	/** minimal constructor */
	public Teljob_bak(long id, Date sgrq, String iscomplete, String jobstatus) {
		this.id = id;
		this.sgrq = sgrq;
		this.iscomplete = iscomplete;
		this.jobstatus = jobstatus;
	}

	/** full constructor */
	public Teljob_bak(long id, String lsh, String cardid, String xdh, String ydh,
			String area, String beginywarea, String ywarea, String hth,
			String yhth, long typeid, long idd, String sgnr, String bz,
			Date sgrq, String dhlx, String jlry, String xm, String nxm,
			String bm1, String bm2, String bm3, String bm4, String yhxz,
			String zw, String xdz, String ydz, String zjlx, String dhgn,
			String linkman, String lxdh, String gzlx, String wxbz, String wxry,
			String yjkx, double yjje, String slbm, String ispay, Date pgrq,
			String mqbm, String jsbm, String pxggbj, String chggbj,
			String jfggbj, String pgrz, Date wgrq, String wgbm,
			String iscomplete, String modual, String port, String typenum,
			double sjje, String payFlag, String value1, String value2,
			String value3, String value4, String value5, String value6,
			String value7, String value8, String value9, String value10,
			String value11, String value12, String value13, String value14,
			String value15, String value16, String value17, String value18,
			String value19, String value20, String ifcancel, String isjudge,
			Date djhwcsj, Date djhswc, String mobile, String jiaofeidh,
			String jobstatus, String ifurgent, int reprinttimesofsf,
			int reprinttimesofjob, String zwbz) {
		this.id = id;
		this.lsh = lsh;
		this.cardid = cardid;
		this.xdh = xdh;
		this.ydh = ydh;
		this.area = area;
		this.beginywarea = beginywarea;
		this.ywarea = ywarea;
		this.hth = hth;
		this.yhth = yhth;
		this.typeid = typeid;
		this.idd = idd;
		this.sgnr = sgnr;
		this.bz = bz;
		this.sgrq = sgrq;
		this.dhlx = dhlx;
		this.jlry = jlry;
		this.xm = xm;
		this.nxm = nxm;
		this.bm1 = bm1;
		this.bm2 = bm2;
		this.bm3 = bm3;
		this.bm4 = bm4;
		this.yhxz = yhxz;
		this.zw = zw;
		this.xdz = xdz;
		this.ydz = ydz;
		this.zjlx = zjlx;
		this.dhgn = dhgn;
		this.linkman = linkman;
		this.lxdh = lxdh;
		this.gzlx = gzlx;
		this.wxbz = wxbz;
		this.wxry = wxry;
		this.yjkx = yjkx;
		this.yjje = yjje;
		this.slbm = slbm;
		this.ispay = ispay;
		this.pgrq = pgrq;
		this.mqbm = mqbm;
		this.jsbm = jsbm;
		this.pxggbj = pxggbj;
		this.chggbj = chggbj;
		this.jfggbj = jfggbj;
		this.pgrz = pgrz;
		this.wgrq = wgrq;
		this.wgbm = wgbm;
		this.iscomplete = iscomplete;
		this.modual = modual;
		this.port = port;
		this.typenum = typenum;
		this.sjje = sjje;
		this.payFlag = payFlag;
		this.value1 = value1;
		this.value2 = value2;
		this.value3 = value3;
		this.value4 = value4;
		this.value5 = value5;
		this.value6 = value6;
		this.value7 = value7;
		this.value8 = value8;
		this.value9 = value9;
		this.value10 = value10;
		this.value11 = value11;
		this.value12 = value12;
		this.value13 = value13;
		this.value14 = value14;
		this.value15 = value15;
		this.value16 = value16;
		this.value17 = value17;
		this.value18 = value18;
		this.value19 = value19;
		this.value20 = value20;
		this.ifcancel = ifcancel;
		this.isjudge = isjudge;
		this.djhwcsj = djhwcsj;
		this.djhswc = djhswc;
		this.mobile = mobile;
		this.jiaofeidh = jiaofeidh;
		this.jobstatus = jobstatus;
		this.ifurgent = ifurgent;
		this.reprinttimesofsf = reprinttimesofsf;
		this.reprinttimesofjob = reprinttimesofjob;
		this.zwbz = zwbz;
	}

	// Property accessors

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getLsh() {
		return this.lsh;
	}

	public void setLsh(String lsh) {
		this.lsh = lsh;
	}

	public String getCardid() {
		return this.cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getXdh() {
		return this.xdh;
	}

	public void setXdh(String xdh) {
		this.xdh = xdh;
	}

	public String getYdh() {
		return this.ydh;
	}

	public void setYdh(String ydh) {
		this.ydh = ydh;
	}

	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getBeginywarea() {
		return this.beginywarea;
	}

	public void setBeginywarea(String beginywarea) {
		this.beginywarea = beginywarea;
	}

	public String getYwarea() {
		return this.ywarea;
	}

	public void setYwarea(String ywarea) {
		this.ywarea = ywarea;
	}

	public String getHth() {
		return this.hth;
	}

	public void setHth(String hth) {
		this.hth = hth;
	}

	public String getYhth() {
		return this.yhth;
	}

	public void setYhth(String yhth) {
		this.yhth = yhth;
	}

	public long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(long typeid) {
		this.typeid = typeid;
	}

	public long getIdd() {
		return this.idd;
	}

	public void setIdd(long idd) {
		this.idd = idd;
	}

	public String getSgnr() {
		return this.sgnr;
	}

	public void setSgnr(String sgnr) {
		this.sgnr = sgnr;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public Date getSgrq() {
		return this.sgrq;
	}

	public void setSgrq(Date sgrq) {
		this.sgrq = sgrq;
	}

	public String getDhlx() {
		return this.dhlx;
	}

	public void setDhlx(String dhlx) {
		this.dhlx = dhlx;
	}

	public String getJlry() {
		return this.jlry;
	}

	public void setJlry(String jlry) {
		this.jlry = jlry;
	}

	public String getXm() {
		return this.xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public String getNxm() {
		return this.nxm;
	}

	public void setNxm(String nxm) {
		this.nxm = nxm;
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

	public String getYhxz() {
		return this.yhxz;
	}

	public void setYhxz(String yhxz) {
		this.yhxz = yhxz;
	}

	public String getZw() {
		return this.zw;
	}

	public void setZw(String zw) {
		this.zw = zw;
	}

	public String getXdz() {
		return this.xdz;
	}

	public void setXdz(String xdz) {
		this.xdz = xdz;
	}

	public String getYdz() {
		return this.ydz;
	}

	public void setYdz(String ydz) {
		this.ydz = ydz;
	}

	public String getZjlx() {
		return this.zjlx;
	}

	public void setZjlx(String zjlx) {
		this.zjlx = zjlx;
	}

	public String getDhgn() {
		return this.dhgn;
	}

	public void setDhgn(String dhgn) {
		this.dhgn = dhgn;
	}

	public String getLinkman() {
		return this.linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getLxdh() {
		return this.lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getGzlx() {
		return this.gzlx;
	}

	public void setGzlx(String gzlx) {
		this.gzlx = gzlx;
	}

	public String getWxbz() {
		return this.wxbz;
	}

	public void setWxbz(String wxbz) {
		this.wxbz = wxbz;
	}

	public String getWxry() {
		return this.wxry;
	}

	public void setWxry(String wxry) {
		this.wxry = wxry;
	}

	public String getYjkx() {
		return this.yjkx;
	}

	public void setYjkx(String yjkx) {
		this.yjkx = yjkx;
	}

	public double getYjje() {
		return this.yjje;
	}

	public void setYjje(double yjje) {
		this.yjje = yjje;
	}

	public String getSlbm() {
		return this.slbm;
	}

	public void setSlbm(String slbm) {
		this.slbm = slbm;
	}

	public String getIspay() {
		return this.ispay;
	}

	public void setIspay(String ispay) {
		this.ispay = ispay;
	}

	public Date getPgrq() {
		return this.pgrq;
	}

	public void setPgrq(Date pgrq) {
		this.pgrq = pgrq;
	}

	public String getMqbm() {
		return this.mqbm;
	}

	public void setMqbm(String mqbm) {
		this.mqbm = mqbm;
	}

	public String getJsbm() {
		return this.jsbm;
	}

	public void setJsbm(String jsbm) {
		this.jsbm = jsbm;
	}

	public String getPxggbj() {
		return this.pxggbj;
	}

	public void setPxggbj(String pxggbj) {
		this.pxggbj = pxggbj;
	}

	public String getChggbj() {
		return this.chggbj;
	}

	public void setChggbj(String chggbj) {
		this.chggbj = chggbj;
	}

	public String getJfggbj() {
		return this.jfggbj;
	}

	public void setJfggbj(String jfggbj) {
		this.jfggbj = jfggbj;
	}

	public String getPgrz() {
		return this.pgrz;
	}

	public void setPgrz(String pgrz) {
		this.pgrz = pgrz;
	}

	public Date getWgrq() {
		return this.wgrq;
	}

	public void setWgrq(Date wgrq) {
		this.wgrq = wgrq;
	}

	public String getWgbm() {
		return this.wgbm;
	}

	public void setWgbm(String wgbm) {
		this.wgbm = wgbm;
	}

	public String getIscomplete() {
		return this.iscomplete;
	}

	public void setIscomplete(String iscomplete) {
		this.iscomplete = iscomplete;
	}

	public String getModual() {
		return this.modual;
	}

	public void setModual(String modual) {
		this.modual = modual;
	}

	public String getPort() {
		return this.port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getTypenum() {
		return this.typenum;
	}

	public void setTypenum(String typenum) {
		this.typenum = typenum;
	}

	public double getSjje() {
		return this.sjje;
	}

	public void setSjje(double sjje) {
		this.sjje = sjje;
	}

	public String getPayFlag() {
		return this.payFlag;
	}

	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}

	public String getValue1() {
		return this.value1;
	}

	public void setValue1(String value1) {
		this.value1 = value1;
	}

	public String getValue2() {
		return this.value2;
	}

	public void setValue2(String value2) {
		this.value2 = value2;
	}

	public String getValue3() {
		return this.value3;
	}

	public void setValue3(String value3) {
		this.value3 = value3;
	}

	public String getValue4() {
		return this.value4;
	}

	public void setValue4(String value4) {
		this.value4 = value4;
	}

	public String getValue5() {
		return this.value5;
	}

	public void setValue5(String value5) {
		this.value5 = value5;
	}

	public String getValue6() {
		return this.value6;
	}

	public void setValue6(String value6) {
		this.value6 = value6;
	}

	public String getValue7() {
		return this.value7;
	}

	public void setValue7(String value7) {
		this.value7 = value7;
	}

	public String getValue8() {
		return this.value8;
	}

	public void setValue8(String value8) {
		this.value8 = value8;
	}

	public String getValue9() {
		return this.value9;
	}

	public void setValue9(String value9) {
		this.value9 = value9;
	}

	public String getValue10() {
		return this.value10;
	}

	public void setValue10(String value10) {
		this.value10 = value10;
	}

	public String getValue11() {
		return this.value11;
	}

	public void setValue11(String value11) {
		this.value11 = value11;
	}

	public String getValue12() {
		return this.value12;
	}

	public void setValue12(String value12) {
		this.value12 = value12;
	}

	public String getValue13() {
		return this.value13;
	}

	public void setValue13(String value13) {
		this.value13 = value13;
	}

	public String getValue14() {
		return this.value14;
	}

	public void setValue14(String value14) {
		this.value14 = value14;
	}

	public String getValue15() {
		return this.value15;
	}

	public void setValue15(String value15) {
		this.value15 = value15;
	}

	public String getValue16() {
		return this.value16;
	}

	public void setValue16(String value16) {
		this.value16 = value16;
	}

	public String getValue17() {
		return this.value17;
	}

	public void setValue17(String value17) {
		this.value17 = value17;
	}

	public String getValue18() {
		return this.value18;
	}

	public void setValue18(String value18) {
		this.value18 = value18;
	}

	public String getValue19() {
		return this.value19;
	}

	public void setValue19(String value19) {
		this.value19 = value19;
	}

	public String getValue20() {
		return this.value20;
	}

	public void setValue20(String value20) {
		this.value20 = value20;
	}

	public String getIfcancel() {
		return this.ifcancel;
	}

	public void setIfcancel(String ifcancel) {
		this.ifcancel = ifcancel;
	}

	public String getIsjudge() {
		return this.isjudge;
	}

	public void setIsjudge(String isjudge) {
		this.isjudge = isjudge;
	}

	public Date getDjhwcsj() {
		return this.djhwcsj;
	}

	public void setDjhwcsj(Date djhwcsj) {
		this.djhwcsj = djhwcsj;
	}

	public Date getDjhswc() {
		return this.djhswc;
	}

	public void setDjhswc(Date djhswc) {
		this.djhswc = djhswc;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getJiaofeidh() {
		return this.jiaofeidh;
	}

	public void setJiaofeidh(String jiaofeidh) {
		this.jiaofeidh = jiaofeidh;
	}

	public String getJobstatus() {
		return this.jobstatus;
	}

	public void setJobstatus(String jobstatus) {
		this.jobstatus = jobstatus;
	}

	public String getIfurgent() {
		return this.ifurgent;
	}

	public void setIfurgent(String ifurgent) {
		this.ifurgent = ifurgent;
	}

	public int getReprinttimesofsf() {
		return this.reprinttimesofsf;
	}

	public void setReprinttimesofsf(int reprinttimesofsf) {
		this.reprinttimesofsf = reprinttimesofsf;
	}

	public int getReprinttimesofjob() {
		return this.reprinttimesofjob;
	}

	public void setReprinttimesofjob(int reprinttimesofjob) {
		this.reprinttimesofjob = reprinttimesofjob;
	}

	public String getZwbz() {
		return this.zwbz;
	}

	public void setZwbz(String zwbz) {
		this.zwbz = zwbz;
	}

}