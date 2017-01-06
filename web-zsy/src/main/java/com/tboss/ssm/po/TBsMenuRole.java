package com.tboss.ssm.po;

import java.math.BigDecimal;

public class TBsMenuRole {
    private BigDecimal id;

    private BigDecimal roleId;

    private BigDecimal menuId;

    private String remark;

    private BigDecimal num1;

    private BigDecimal num2;

    private BigDecimal num3;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getRoleId() {
        return roleId;
    }

    public void setRoleId(BigDecimal roleId) {
        this.roleId = roleId;
    }

    public BigDecimal getMenuId() {
        return menuId;
    }

    public void setMenuId(BigDecimal menuId) {
        this.menuId = menuId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public BigDecimal getNum1() {
        return num1;
    }

    public void setNum1(BigDecimal num1) {
        this.num1 = num1;
    }

    public BigDecimal getNum2() {
        return num2;
    }

    public void setNum2(BigDecimal num2) {
        this.num2 = num2;
    }

    public BigDecimal getNum3() {
        return num3;
    }

    public void setNum3(BigDecimal num3) {
        this.num3 = num3;
    }
}