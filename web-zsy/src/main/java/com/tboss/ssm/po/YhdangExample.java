package com.tboss.ssm.po;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.codehaus.jackson.annotate.JsonTypeInfo.As;

public class YhdangExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public YhdangExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        protected void addCriterionForJDBCDate(String condition, Date value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            addCriterion(condition, new java.sql.Date(value.getTime()), property);
        }

        protected void addCriterionForJDBCDate(String condition, List<Date> values, String property) {
            if (values == null || values.size() == 0) {
                throw new RuntimeException("Value list for " + property + " cannot be null or empty");
            }
            List<java.sql.Date> dateList = new ArrayList<java.sql.Date>();
            Iterator<Date> iter = values.iterator();
            while (iter.hasNext()) {
                dateList.add(new java.sql.Date(iter.next().getTime()));
            }
            addCriterion(condition, dateList, property);
        }

        protected void addCriterionForJDBCDate(String condition, Date value1, Date value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            addCriterion(condition, new java.sql.Date(value1.getTime()), new java.sql.Date(value2.getTime()), property);
        }

        public Criteria andDhIsNull() {
            addCriterion("DH is null");
            return (Criteria) this;
        }

        public Criteria andDhIsNotNull() {
            addCriterion("DH is not null");
            return (Criteria) this;
        }

        public Criteria andDhEqualTo(String value) {
            addCriterion("DH =", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhNotEqualTo(String value) {
            addCriterion("DH <>", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhGreaterThan(String value) {
            addCriterion("DH >", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhGreaterThanOrEqualTo(String value) {
            addCriterion("DH >=", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhLessThan(String value) {
            addCriterion("DH <", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhLessThanOrEqualTo(String value) {
            addCriterion("DH <=", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhLike(String value) {
            addCriterion("DH like", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhNotLike(String value) {
            addCriterion("DH not like", value, "dh");
            return (Criteria) this;
        }

        public Criteria andDhIn(List<String> values) {
            addCriterion("DH in", values, "dh");
            return (Criteria) this;
        }

        public Criteria andDhNotIn(List<String> values) {
            addCriterion("DH not in", values, "dh");
            return (Criteria) this;
        }

        public Criteria andDhBetween(String value1, String value2) {
            addCriterion("DH between", value1, value2, "dh");
            return (Criteria) this;
        }

        public Criteria andDhNotBetween(String value1, String value2) {
            addCriterion("DH not between", value1, value2, "dh");
            return (Criteria) this;
        }

        public Criteria andHthIsNull() {
            addCriterion("HTH is null");
            return (Criteria) this;
        }

        public Criteria andHthIsNotNull() {
            addCriterion("HTH is not null");
            return (Criteria) this;
        }

        public Criteria andHthEqualTo(String value) {
            addCriterion("HTH =", value, "hth");
            return (Criteria) this;
        }
       
     
        public Criteria andHthNotEqualTo(String value) {
            addCriterion("HTH <>", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthGreaterThan(String value) {
            addCriterion("HTH >", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthGreaterThanOrEqualTo(String value) {
            addCriterion("HTH >=", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthLessThan(String value) {
            addCriterion("HTH <", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthLessThanOrEqualTo(String value) {
            addCriterion("HTH <=", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthLike(String value) {
            addCriterion("HTH like", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthNotLike(String value) {
            addCriterion("HTH not like", value, "hth");
            return (Criteria) this;
        }

        public Criteria andHthIn(List<String> values) {
            addCriterion("HTH in", values, "hth");
            return (Criteria) this;
        }

        public Criteria andHthNotIn(List<String> values) {
            addCriterion("HTH not in", values, "hth");
            return (Criteria) this;
        }

        public Criteria andHthBetween(String value1, String value2) {
            addCriterion("HTH between", value1, value2, "hth");
            return (Criteria) this;
        }

        public Criteria andHthNotBetween(String value1, String value2) {
            addCriterion("HTH not between", value1, value2, "hth");
            return (Criteria) this;
        }

        public Criteria andJxhIsNull() {
            addCriterion("JXH is null");
            return (Criteria) this;
        }

        public Criteria andJxhIsNotNull() {
            addCriterion("JXH is not null");
            return (Criteria) this;
        }

        public Criteria andJxhEqualTo(String value) {
            addCriterion("JXH =", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhNotEqualTo(String value) {
            addCriterion("JXH <>", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhGreaterThan(String value) {
            addCriterion("JXH >", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhGreaterThanOrEqualTo(String value) {
            addCriterion("JXH >=", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhLessThan(String value) {
            addCriterion("JXH <", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhLessThanOrEqualTo(String value) {
            addCriterion("JXH <=", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhLike(String value) {
            addCriterion("JXH like", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhNotLike(String value) {
            addCriterion("JXH not like", value, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhIn(List<String> values) {
            addCriterion("JXH in", values, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhNotIn(List<String> values) {
            addCriterion("JXH not in", values, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhBetween(String value1, String value2) {
            addCriterion("JXH between", value1, value2, "jxh");
            return (Criteria) this;
        }

        public Criteria andJxhNotBetween(String value1, String value2) {
            addCriterion("JXH not between", value1, value2, "jxh");
            return (Criteria) this;
        }

        public Criteria andYhmcIsNull() {
            addCriterion("YHMC is null");
            return (Criteria) this;
        }

        public Criteria andYhmcIsNotNull() {
            addCriterion("YHMC is not null");
            return (Criteria) this;
        }

        public Criteria andYhmcEqualTo(String value) {
            addCriterion("YHMC =", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcNotEqualTo(String value) {
            addCriterion("YHMC <>", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcGreaterThan(String value) {
            addCriterion("YHMC >", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcGreaterThanOrEqualTo(String value) {
            addCriterion("YHMC >=", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcLessThan(String value) {
            addCriterion("YHMC <", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcLessThanOrEqualTo(String value) {
            addCriterion("YHMC <=", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcLike(String value) {
            addCriterion("YHMC like", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcNotLike(String value) {
            addCriterion("YHMC not like", value, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcIn(List<String> values) {
            addCriterion("YHMC in", values, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcNotIn(List<String> values) {
            addCriterion("YHMC not in", values, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcBetween(String value1, String value2) {
            addCriterion("YHMC between", value1, value2, "yhmc");
            return (Criteria) this;
        }

        public Criteria andYhmcNotBetween(String value1, String value2) {
            addCriterion("YHMC not between", value1, value2, "yhmc");
            return (Criteria) this;
        }

        public Criteria andBm1IsNull() {
            addCriterion("BM1 is null");
            return (Criteria) this;
        }

        public Criteria andBm1IsNotNull() {
            addCriterion("BM1 is not null");
            return (Criteria) this;
        }

        public Criteria andBm1EqualTo(String value) {
            addCriterion("BM1 =", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1NotEqualTo(String value) {
            addCriterion("BM1 <>", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1GreaterThan(String value) {
            addCriterion("BM1 >", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1GreaterThanOrEqualTo(String value) {
            addCriterion("BM1 >=", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1LessThan(String value) {
            addCriterion("BM1 <", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1LessThanOrEqualTo(String value) {
            addCriterion("BM1 <=", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1Like(String value) {
            addCriterion("BM1 like", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1NotLike(String value) {
            addCriterion("BM1 not like", value, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1In(List<String> values) {
            addCriterion("BM1 in", values, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1NotIn(List<String> values) {
            addCriterion("BM1 not in", values, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1Between(String value1, String value2) {
            addCriterion("BM1 between", value1, value2, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm1NotBetween(String value1, String value2) {
            addCriterion("BM1 not between", value1, value2, "bm1");
            return (Criteria) this;
        }

        public Criteria andBm2IsNull() {
            addCriterion("BM2 is null");
            return (Criteria) this;
        }

        public Criteria andBm2IsNotNull() {
            addCriterion("BM2 is not null");
            return (Criteria) this;
        }

        public Criteria andBm2EqualTo(String value) {
            addCriterion("BM2 =", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2NotEqualTo(String value) {
            addCriterion("BM2 <>", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2GreaterThan(String value) {
            addCriterion("BM2 >", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2GreaterThanOrEqualTo(String value) {
            addCriterion("BM2 >=", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2LessThan(String value) {
            addCriterion("BM2 <", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2LessThanOrEqualTo(String value) {
            addCriterion("BM2 <=", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2Like(String value) {
            addCriterion("BM2 like", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2NotLike(String value) {
            addCriterion("BM2 not like", value, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2In(List<String> values) {
            addCriterion("BM2 in", values, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2NotIn(List<String> values) {
            addCriterion("BM2 not in", values, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2Between(String value1, String value2) {
            addCriterion("BM2 between", value1, value2, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm2NotBetween(String value1, String value2) {
            addCriterion("BM2 not between", value1, value2, "bm2");
            return (Criteria) this;
        }

        public Criteria andBm3IsNull() {
            addCriterion("BM3 is null");
            return (Criteria) this;
        }

        public Criteria andBm3IsNotNull() {
            addCriterion("BM3 is not null");
            return (Criteria) this;
        }

        public Criteria andBm3EqualTo(String value) {
            addCriterion("BM3 =", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3NotEqualTo(String value) {
            addCriterion("BM3 <>", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3GreaterThan(String value) {
            addCriterion("BM3 >", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3GreaterThanOrEqualTo(String value) {
            addCriterion("BM3 >=", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3LessThan(String value) {
            addCriterion("BM3 <", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3LessThanOrEqualTo(String value) {
            addCriterion("BM3 <=", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3Like(String value) {
            addCriterion("BM3 like", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3NotLike(String value) {
            addCriterion("BM3 not like", value, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3In(List<String> values) {
            addCriterion("BM3 in", values, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3NotIn(List<String> values) {
            addCriterion("BM3 not in", values, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3Between(String value1, String value2) {
            addCriterion("BM3 between", value1, value2, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm3NotBetween(String value1, String value2) {
            addCriterion("BM3 not between", value1, value2, "bm3");
            return (Criteria) this;
        }

        public Criteria andBm4IsNull() {
            addCriterion("BM4 is null");
            return (Criteria) this;
        }

        public Criteria andBm4IsNotNull() {
            addCriterion("BM4 is not null");
            return (Criteria) this;
        }

        public Criteria andBm4EqualTo(String value) {
            addCriterion("BM4 =", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4NotEqualTo(String value) {
            addCriterion("BM4 <>", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4GreaterThan(String value) {
            addCriterion("BM4 >", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4GreaterThanOrEqualTo(String value) {
            addCriterion("BM4 >=", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4LessThan(String value) {
            addCriterion("BM4 <", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4LessThanOrEqualTo(String value) {
            addCriterion("BM4 <=", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4Like(String value) {
            addCriterion("BM4 like", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4NotLike(String value) {
            addCriterion("BM4 not like", value, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4In(List<String> values) {
            addCriterion("BM4 in", values, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4NotIn(List<String> values) {
            addCriterion("BM4 not in", values, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4Between(String value1, String value2) {
            addCriterion("BM4 between", value1, value2, "bm4");
            return (Criteria) this;
        }

        public Criteria andBm4NotBetween(String value1, String value2) {
            addCriterion("BM4 not between", value1, value2, "bm4");
            return (Criteria) this;
        }

        public Criteria andBmbhIsNull() {
            addCriterion("BMBH is null");
            return (Criteria) this;
        }

        public Criteria andBmbhIsNotNull() {
            addCriterion("BMBH is not null");
            return (Criteria) this;
        }

        public Criteria andBmbhEqualTo(String value) {
            addCriterion("BMBH =", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhNotEqualTo(String value) {
            addCriterion("BMBH <>", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhGreaterThan(String value) {
            addCriterion("BMBH >", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhGreaterThanOrEqualTo(String value) {
            addCriterion("BMBH >=", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhLessThan(String value) {
            addCriterion("BMBH <", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhLessThanOrEqualTo(String value) {
            addCriterion("BMBH <=", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhLike(String value) {
            addCriterion("BMBH like", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhNotLike(String value) {
            addCriterion("BMBH not like", value, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhIn(List<String> values) {
            addCriterion("BMBH in", values, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhNotIn(List<String> values) {
            addCriterion("BMBH not in", values, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhBetween(String value1, String value2) {
            addCriterion("BMBH between", value1, value2, "bmbh");
            return (Criteria) this;
        }

        public Criteria andBmbhNotBetween(String value1, String value2) {
            addCriterion("BMBH not between", value1, value2, "bmbh");
            return (Criteria) this;
        }

        public Criteria andYhdzIsNull() {
            addCriterion("YHDZ is null");
            return (Criteria) this;
        }

        public Criteria andYhdzIsNotNull() {
            addCriterion("YHDZ is not null");
            return (Criteria) this;
        }

        public Criteria andYhdzEqualTo(String value) {
            addCriterion("YHDZ =", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzNotEqualTo(String value) {
            addCriterion("YHDZ <>", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzGreaterThan(String value) {
            addCriterion("YHDZ >", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzGreaterThanOrEqualTo(String value) {
            addCriterion("YHDZ >=", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzLessThan(String value) {
            addCriterion("YHDZ <", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzLessThanOrEqualTo(String value) {
            addCriterion("YHDZ <=", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzLike(String value) {
            addCriterion("YHDZ like", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzNotLike(String value) {
            addCriterion("YHDZ not like", value, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzIn(List<String> values) {
            addCriterion("YHDZ in", values, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzNotIn(List<String> values) {
            addCriterion("YHDZ not in", values, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzBetween(String value1, String value2) {
            addCriterion("YHDZ between", value1, value2, "yhdz");
            return (Criteria) this;
        }

        public Criteria andYhdzNotBetween(String value1, String value2) {
            addCriterion("YHDZ not between", value1, value2, "yhdz");
            return (Criteria) this;
        }

        public Criteria andHwjbIsNull() {
            addCriterion("HWJB is null");
            return (Criteria) this;
        }

        public Criteria andHwjbIsNotNull() {
            addCriterion("HWJB is not null");
            return (Criteria) this;
        }

        public Criteria andHwjbEqualTo(String value) {
            addCriterion("HWJB =", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbNotEqualTo(String value) {
            addCriterion("HWJB <>", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbGreaterThan(String value) {
            addCriterion("HWJB >", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbGreaterThanOrEqualTo(String value) {
            addCriterion("HWJB >=", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbLessThan(String value) {
            addCriterion("HWJB <", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbLessThanOrEqualTo(String value) {
            addCriterion("HWJB <=", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbLike(String value) {
            addCriterion("HWJB like", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbNotLike(String value) {
            addCriterion("HWJB not like", value, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbIn(List<String> values) {
            addCriterion("HWJB in", values, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbNotIn(List<String> values) {
            addCriterion("HWJB not in", values, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbBetween(String value1, String value2) {
            addCriterion("HWJB between", value1, value2, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjbNotBetween(String value1, String value2) {
            addCriterion("HWJB not between", value1, value2, "hwjb");
            return (Criteria) this;
        }

        public Criteria andHwjb0IsNull() {
            addCriterion("HWJB0 is null");
            return (Criteria) this;
        }

        public Criteria andHwjb0IsNotNull() {
            addCriterion("HWJB0 is not null");
            return (Criteria) this;
        }

        public Criteria andHwjb0EqualTo(String value) {
            addCriterion("HWJB0 =", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0NotEqualTo(String value) {
            addCriterion("HWJB0 <>", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0GreaterThan(String value) {
            addCriterion("HWJB0 >", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0GreaterThanOrEqualTo(String value) {
            addCriterion("HWJB0 >=", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0LessThan(String value) {
            addCriterion("HWJB0 <", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0LessThanOrEqualTo(String value) {
            addCriterion("HWJB0 <=", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0Like(String value) {
            addCriterion("HWJB0 like", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0NotLike(String value) {
            addCriterion("HWJB0 not like", value, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0In(List<String> values) {
            addCriterion("HWJB0 in", values, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0NotIn(List<String> values) {
            addCriterion("HWJB0 not in", values, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0Between(String value1, String value2) {
            addCriterion("HWJB0 between", value1, value2, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb0NotBetween(String value1, String value2) {
            addCriterion("HWJB0 not between", value1, value2, "hwjb0");
            return (Criteria) this;
        }

        public Criteria andHwjb1IsNull() {
            addCriterion("HWJB1 is null");
            return (Criteria) this;
        }

        public Criteria andHwjb1IsNotNull() {
            addCriterion("HWJB1 is not null");
            return (Criteria) this;
        }

        public Criteria andHwjb1EqualTo(String value) {
            addCriterion("HWJB1 =", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1NotEqualTo(String value) {
            addCriterion("HWJB1 <>", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1GreaterThan(String value) {
            addCriterion("HWJB1 >", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1GreaterThanOrEqualTo(String value) {
            addCriterion("HWJB1 >=", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1LessThan(String value) {
            addCriterion("HWJB1 <", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1LessThanOrEqualTo(String value) {
            addCriterion("HWJB1 <=", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1Like(String value) {
            addCriterion("HWJB1 like", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1NotLike(String value) {
            addCriterion("HWJB1 not like", value, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1In(List<String> values) {
            addCriterion("HWJB1 in", values, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1NotIn(List<String> values) {
            addCriterion("HWJB1 not in", values, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1Between(String value1, String value2) {
            addCriterion("HWJB1 between", value1, value2, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andHwjb1NotBetween(String value1, String value2) {
            addCriterion("HWJB1 not between", value1, value2, "hwjb1");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateIsNull() {
            addCriterion("LASTADJUSTDATE is null");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateIsNotNull() {
            addCriterion("LASTADJUSTDATE is not null");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateEqualTo(Date value) {
            addCriterionForJDBCDate("LASTADJUSTDATE =", value, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateNotEqualTo(Date value) {
            addCriterionForJDBCDate("LASTADJUSTDATE <>", value, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateGreaterThan(Date value) {
            addCriterionForJDBCDate("LASTADJUSTDATE >", value, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("LASTADJUSTDATE >=", value, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateLessThan(Date value) {
            addCriterionForJDBCDate("LASTADJUSTDATE <", value, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("LASTADJUSTDATE <=", value, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateIn(List<Date> values) {
            addCriterionForJDBCDate("LASTADJUSTDATE in", values, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateNotIn(List<Date> values) {
            addCriterionForJDBCDate("LASTADJUSTDATE not in", values, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("LASTADJUSTDATE between", value1, value2, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andLastadjustdateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("LASTADJUSTDATE not between", value1, value2, "lastadjustdate");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoIsNull() {
            addCriterion("CALLSHEDULENO is null");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoIsNotNull() {
            addCriterion("CALLSHEDULENO is not null");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoEqualTo(String value) {
            addCriterion("CALLSHEDULENO =", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoNotEqualTo(String value) {
            addCriterion("CALLSHEDULENO <>", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoGreaterThan(String value) {
            addCriterion("CALLSHEDULENO >", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoGreaterThanOrEqualTo(String value) {
            addCriterion("CALLSHEDULENO >=", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoLessThan(String value) {
            addCriterion("CALLSHEDULENO <", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoLessThanOrEqualTo(String value) {
            addCriterion("CALLSHEDULENO <=", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoLike(String value) {
            addCriterion("CALLSHEDULENO like", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoNotLike(String value) {
            addCriterion("CALLSHEDULENO not like", value, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoIn(List<String> values) {
            addCriterion("CALLSHEDULENO in", values, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoNotIn(List<String> values) {
            addCriterion("CALLSHEDULENO not in", values, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoBetween(String value1, String value2) {
            addCriterion("CALLSHEDULENO between", value1, value2, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andCallshedulenoNotBetween(String value1, String value2) {
            addCriterion("CALLSHEDULENO not between", value1, value2, "callsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoIsNull() {
            addCriterion("ADJUSTSHEDULENO is null");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoIsNotNull() {
            addCriterion("ADJUSTSHEDULENO is not null");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoEqualTo(String value) {
            addCriterion("ADJUSTSHEDULENO =", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoNotEqualTo(String value) {
            addCriterion("ADJUSTSHEDULENO <>", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoGreaterThan(String value) {
            addCriterion("ADJUSTSHEDULENO >", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoGreaterThanOrEqualTo(String value) {
            addCriterion("ADJUSTSHEDULENO >=", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoLessThan(String value) {
            addCriterion("ADJUSTSHEDULENO <", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoLessThanOrEqualTo(String value) {
            addCriterion("ADJUSTSHEDULENO <=", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoLike(String value) {
            addCriterion("ADJUSTSHEDULENO like", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoNotLike(String value) {
            addCriterion("ADJUSTSHEDULENO not like", value, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoIn(List<String> values) {
            addCriterion("ADJUSTSHEDULENO in", values, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoNotIn(List<String> values) {
            addCriterion("ADJUSTSHEDULENO not in", values, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoBetween(String value1, String value2) {
            addCriterion("ADJUSTSHEDULENO between", value1, value2, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andAdjustshedulenoNotBetween(String value1, String value2) {
            addCriterion("ADJUSTSHEDULENO not between", value1, value2, "adjustsheduleno");
            return (Criteria) this;
        }

        public Criteria andZlhIsNull() {
            addCriterion("ZLH is null");
            return (Criteria) this;
        }

        public Criteria andZlhIsNotNull() {
            addCriterion("ZLH is not null");
            return (Criteria) this;
        }

        public Criteria andZlhEqualTo(String value) {
            addCriterion("ZLH =", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhNotEqualTo(String value) {
            addCriterion("ZLH <>", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhGreaterThan(String value) {
            addCriterion("ZLH >", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhGreaterThanOrEqualTo(String value) {
            addCriterion("ZLH >=", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhLessThan(String value) {
            addCriterion("ZLH <", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhLessThanOrEqualTo(String value) {
            addCriterion("ZLH <=", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhLike(String value) {
            addCriterion("ZLH like", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhNotLike(String value) {
            addCriterion("ZLH not like", value, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhIn(List<String> values) {
            addCriterion("ZLH in", values, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhNotIn(List<String> values) {
            addCriterion("ZLH not in", values, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhBetween(String value1, String value2) {
            addCriterion("ZLH between", value1, value2, "zlh");
            return (Criteria) this;
        }

        public Criteria andZlhNotBetween(String value1, String value2) {
            addCriterion("ZLH not between", value1, value2, "zlh");
            return (Criteria) this;
        }

        public Criteria andJflbIsNull() {
            addCriterion("JFLB is null");
            return (Criteria) this;
        }

        public Criteria andJflbIsNotNull() {
            addCriterion("JFLB is not null");
            return (Criteria) this;
        }

        public Criteria andJflbEqualTo(String value) {
            addCriterion("JFLB =", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbNotEqualTo(String value) {
            addCriterion("JFLB <>", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbGreaterThan(String value) {
            addCriterion("JFLB >", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbGreaterThanOrEqualTo(String value) {
            addCriterion("JFLB >=", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbLessThan(String value) {
            addCriterion("JFLB <", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbLessThanOrEqualTo(String value) {
            addCriterion("JFLB <=", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbLike(String value) {
            addCriterion("JFLB like", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbNotLike(String value) {
            addCriterion("JFLB not like", value, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbIn(List<String> values) {
            addCriterion("JFLB in", values, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbNotIn(List<String> values) {
            addCriterion("JFLB not in", values, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbBetween(String value1, String value2) {
            addCriterion("JFLB between", value1, value2, "jflb");
            return (Criteria) this;
        }

        public Criteria andJflbNotBetween(String value1, String value2) {
            addCriterion("JFLB not between", value1, value2, "jflb");
            return (Criteria) this;
        }

        public Criteria andMfjbIsNull() {
            addCriterion("MFJB is null");
            return (Criteria) this;
        }

        public Criteria andMfjbIsNotNull() {
            addCriterion("MFJB is not null");
            return (Criteria) this;
        }

        public Criteria andMfjbEqualTo(String value) {
            addCriterion("MFJB =", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbNotEqualTo(String value) {
            addCriterion("MFJB <>", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbGreaterThan(String value) {
            addCriterion("MFJB >", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbGreaterThanOrEqualTo(String value) {
            addCriterion("MFJB >=", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbLessThan(String value) {
            addCriterion("MFJB <", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbLessThanOrEqualTo(String value) {
            addCriterion("MFJB <=", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbLike(String value) {
            addCriterion("MFJB like", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbNotLike(String value) {
            addCriterion("MFJB not like", value, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbIn(List<String> values) {
            addCriterion("MFJB in", values, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbNotIn(List<String> values) {
            addCriterion("MFJB not in", values, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbBetween(String value1, String value2) {
            addCriterion("MFJB between", value1, value2, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMfjbNotBetween(String value1, String value2) {
            addCriterion("MFJB not between", value1, value2, "mfjb");
            return (Criteria) this;
        }

        public Criteria andMimaIsNull() {
            addCriterion("MIMA is null");
            return (Criteria) this;
        }

        public Criteria andMimaIsNotNull() {
            addCriterion("MIMA is not null");
            return (Criteria) this;
        }

        public Criteria andMimaEqualTo(String value) {
            addCriterion("MIMA =", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaNotEqualTo(String value) {
            addCriterion("MIMA <>", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaGreaterThan(String value) {
            addCriterion("MIMA >", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaGreaterThanOrEqualTo(String value) {
            addCriterion("MIMA >=", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaLessThan(String value) {
            addCriterion("MIMA <", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaLessThanOrEqualTo(String value) {
            addCriterion("MIMA <=", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaLike(String value) {
            addCriterion("MIMA like", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaNotLike(String value) {
            addCriterion("MIMA not like", value, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaIn(List<String> values) {
            addCriterion("MIMA in", values, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaNotIn(List<String> values) {
            addCriterion("MIMA not in", values, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaBetween(String value1, String value2) {
            addCriterion("MIMA between", value1, value2, "mima");
            return (Criteria) this;
        }

        public Criteria andMimaNotBetween(String value1, String value2) {
            addCriterion("MIMA not between", value1, value2, "mima");
            return (Criteria) this;
        }

        public Criteria andMima2IsNull() {
            addCriterion("MIMA2 is null");
            return (Criteria) this;
        }

        public Criteria andMima2IsNotNull() {
            addCriterion("MIMA2 is not null");
            return (Criteria) this;
        }

        public Criteria andMima2EqualTo(String value) {
            addCriterion("MIMA2 =", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2NotEqualTo(String value) {
            addCriterion("MIMA2 <>", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2GreaterThan(String value) {
            addCriterion("MIMA2 >", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2GreaterThanOrEqualTo(String value) {
            addCriterion("MIMA2 >=", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2LessThan(String value) {
            addCriterion("MIMA2 <", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2LessThanOrEqualTo(String value) {
            addCriterion("MIMA2 <=", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2Like(String value) {
            addCriterion("MIMA2 like", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2NotLike(String value) {
            addCriterion("MIMA2 not like", value, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2In(List<String> values) {
            addCriterion("MIMA2 in", values, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2NotIn(List<String> values) {
            addCriterion("MIMA2 not in", values, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2Between(String value1, String value2) {
            addCriterion("MIMA2 between", value1, value2, "mima2");
            return (Criteria) this;
        }

        public Criteria andMima2NotBetween(String value1, String value2) {
            addCriterion("MIMA2 not between", value1, value2, "mima2");
            return (Criteria) this;
        }

        public Criteria andRegDateIsNull() {
            addCriterion("REG_DATE is null");
            return (Criteria) this;
        }

        public Criteria andRegDateIsNotNull() {
            addCriterion("REG_DATE is not null");
            return (Criteria) this;
        }

        public Criteria andRegDateEqualTo(Date value) {
            addCriterionForJDBCDate("REG_DATE =", value, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateNotEqualTo(Date value) {
            addCriterionForJDBCDate("REG_DATE <>", value, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateGreaterThan(Date value) {
            addCriterionForJDBCDate("REG_DATE >", value, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("REG_DATE >=", value, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateLessThan(Date value) {
            addCriterionForJDBCDate("REG_DATE <", value, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("REG_DATE <=", value, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateIn(List<Date> values) {
            addCriterionForJDBCDate("REG_DATE in", values, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateNotIn(List<Date> values) {
            addCriterionForJDBCDate("REG_DATE not in", values, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("REG_DATE between", value1, value2, "regDate");
            return (Criteria) this;
        }

        public Criteria andRegDateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("REG_DATE not between", value1, value2, "regDate");
            return (Criteria) this;
        }

        public Criteria andStartdateIsNull() {
            addCriterion("STARTDATE is null");
            return (Criteria) this;
        }

        public Criteria andStartdateIsNotNull() {
            addCriterion("STARTDATE is not null");
            return (Criteria) this;
        }

        public Criteria andStartdateEqualTo(Date value) {
            addCriterionForJDBCDate("STARTDATE =", value, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateNotEqualTo(Date value) {
            addCriterionForJDBCDate("STARTDATE <>", value, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateGreaterThan(Date value) {
            addCriterionForJDBCDate("STARTDATE >", value, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("STARTDATE >=", value, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateLessThan(Date value) {
            addCriterionForJDBCDate("STARTDATE <", value, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("STARTDATE <=", value, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateIn(List<Date> values) {
            addCriterionForJDBCDate("STARTDATE in", values, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateNotIn(List<Date> values) {
            addCriterionForJDBCDate("STARTDATE not in", values, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("STARTDATE between", value1, value2, "startdate");
            return (Criteria) this;
        }

        public Criteria andStartdateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("STARTDATE not between", value1, value2, "startdate");
            return (Criteria) this;
        }

        public Criteria andEnddateIsNull() {
            addCriterion("ENDDATE is null");
            return (Criteria) this;
        }

        public Criteria andEnddateIsNotNull() {
            addCriterion("ENDDATE is not null");
            return (Criteria) this;
        }

        public Criteria andEnddateEqualTo(Date value) {
            addCriterionForJDBCDate("ENDDATE =", value, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateNotEqualTo(Date value) {
            addCriterionForJDBCDate("ENDDATE <>", value, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateGreaterThan(Date value) {
            addCriterionForJDBCDate("ENDDATE >", value, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("ENDDATE >=", value, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateLessThan(Date value) {
            addCriterionForJDBCDate("ENDDATE <", value, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("ENDDATE <=", value, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateIn(List<Date> values) {
            addCriterionForJDBCDate("ENDDATE in", values, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateNotIn(List<Date> values) {
            addCriterionForJDBCDate("ENDDATE not in", values, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("ENDDATE between", value1, value2, "enddate");
            return (Criteria) this;
        }

        public Criteria andEnddateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("ENDDATE not between", value1, value2, "enddate");
            return (Criteria) this;
        }

        public Criteria andTjbzIsNull() {
            addCriterion("TJBZ is null");
            return (Criteria) this;
        }

        public Criteria andTjbzIsNotNull() {
            addCriterion("TJBZ is not null");
            return (Criteria) this;
        }

        public Criteria andTjbzEqualTo(String value) {
            addCriterion("TJBZ =", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzNotEqualTo(String value) {
            addCriterion("TJBZ <>", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzGreaterThan(String value) {
            addCriterion("TJBZ >", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzGreaterThanOrEqualTo(String value) {
            addCriterion("TJBZ >=", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzLessThan(String value) {
            addCriterion("TJBZ <", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzLessThanOrEqualTo(String value) {
            addCriterion("TJBZ <=", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzLike(String value) {
            addCriterion("TJBZ like", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzNotLike(String value) {
            addCriterion("TJBZ not like", value, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzIn(List<String> values) {
            addCriterion("TJBZ in", values, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzNotIn(List<String> values) {
            addCriterion("TJBZ not in", values, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzBetween(String value1, String value2) {
            addCriterion("TJBZ between", value1, value2, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjbzNotBetween(String value1, String value2) {
            addCriterion("TJBZ not between", value1, value2, "tjbz");
            return (Criteria) this;
        }

        public Criteria andTjdateIsNull() {
            addCriterion("TJDATE is null");
            return (Criteria) this;
        }

        public Criteria andTjdateIsNotNull() {
            addCriterion("TJDATE is not null");
            return (Criteria) this;
        }

        public Criteria andTjdateEqualTo(Date value) {
            addCriterionForJDBCDate("TJDATE =", value, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateNotEqualTo(Date value) {
            addCriterionForJDBCDate("TJDATE <>", value, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateGreaterThan(Date value) {
            addCriterionForJDBCDate("TJDATE >", value, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("TJDATE >=", value, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateLessThan(Date value) {
            addCriterionForJDBCDate("TJDATE <", value, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("TJDATE <=", value, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateIn(List<Date> values) {
            addCriterionForJDBCDate("TJDATE in", values, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateNotIn(List<Date> values) {
            addCriterionForJDBCDate("TJDATE not in", values, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("TJDATE between", value1, value2, "tjdate");
            return (Criteria) this;
        }

        public Criteria andTjdateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("TJDATE not between", value1, value2, "tjdate");
            return (Criteria) this;
        }

        public Criteria andStopbzIsNull() {
            addCriterion("STOPBZ is null");
            return (Criteria) this;
        }

        public Criteria andStopbzIsNotNull() {
            addCriterion("STOPBZ is not null");
            return (Criteria) this;
        }

        public Criteria andStopbzEqualTo(String value) {
            addCriterion("STOPBZ =", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzNotEqualTo(String value) {
            addCriterion("STOPBZ <>", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzGreaterThan(String value) {
            addCriterion("STOPBZ >", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzGreaterThanOrEqualTo(String value) {
            addCriterion("STOPBZ >=", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzLessThan(String value) {
            addCriterion("STOPBZ <", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzLessThanOrEqualTo(String value) {
            addCriterion("STOPBZ <=", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzLike(String value) {
            addCriterion("STOPBZ like", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzNotLike(String value) {
            addCriterion("STOPBZ not like", value, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzIn(List<String> values) {
            addCriterion("STOPBZ in", values, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzNotIn(List<String> values) {
            addCriterion("STOPBZ not in", values, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzBetween(String value1, String value2) {
            addCriterion("STOPBZ between", value1, value2, "stopbz");
            return (Criteria) this;
        }

        public Criteria andStopbzNotBetween(String value1, String value2) {
            addCriterion("STOPBZ not between", value1, value2, "stopbz");
            return (Criteria) this;
        }

        public Criteria andDelbzIsNull() {
            addCriterion("DELBZ is null");
            return (Criteria) this;
        }

        public Criteria andDelbzIsNotNull() {
            addCriterion("DELBZ is not null");
            return (Criteria) this;
        }

        public Criteria andDelbzEqualTo(String value) {
            addCriterion("DELBZ =", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzNotEqualTo(String value) {
            addCriterion("DELBZ <>", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzGreaterThan(String value) {
            addCriterion("DELBZ >", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzGreaterThanOrEqualTo(String value) {
            addCriterion("DELBZ >=", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzLessThan(String value) {
            addCriterion("DELBZ <", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzLessThanOrEqualTo(String value) {
            addCriterion("DELBZ <=", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzLike(String value) {
            addCriterion("DELBZ like", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzNotLike(String value) {
            addCriterion("DELBZ not like", value, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzIn(List<String> values) {
            addCriterion("DELBZ in", values, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzNotIn(List<String> values) {
            addCriterion("DELBZ not in", values, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzBetween(String value1, String value2) {
            addCriterion("DELBZ between", value1, value2, "delbz");
            return (Criteria) this;
        }

        public Criteria andDelbzNotBetween(String value1, String value2) {
            addCriterion("DELBZ not between", value1, value2, "delbz");
            return (Criteria) this;
        }

        public Criteria andDeldateIsNull() {
            addCriterion("DELDATE is null");
            return (Criteria) this;
        }

        public Criteria andDeldateIsNotNull() {
            addCriterion("DELDATE is not null");
            return (Criteria) this;
        }

        public Criteria andDeldateEqualTo(Date value) {
            addCriterionForJDBCDate("DELDATE =", value, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateNotEqualTo(Date value) {
            addCriterionForJDBCDate("DELDATE <>", value, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateGreaterThan(Date value) {
            addCriterionForJDBCDate("DELDATE >", value, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("DELDATE >=", value, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateLessThan(Date value) {
            addCriterionForJDBCDate("DELDATE <", value, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("DELDATE <=", value, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateIn(List<Date> values) {
            addCriterionForJDBCDate("DELDATE in", values, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateNotIn(List<Date> values) {
            addCriterionForJDBCDate("DELDATE not in", values, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("DELDATE between", value1, value2, "deldate");
            return (Criteria) this;
        }

        public Criteria andDeldateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("DELDATE not between", value1, value2, "deldate");
            return (Criteria) this;
        }

        public Criteria andDhlxIsNull() {
            addCriterion("DHLX is null");
            return (Criteria) this;
        }

        public Criteria andDhlxIsNotNull() {
            addCriterion("DHLX is not null");
            return (Criteria) this;
        }

        public Criteria andDhlxEqualTo(String value) {
            addCriterion("DHLX =", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxNotEqualTo(String value) {
            addCriterion("DHLX <>", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxGreaterThan(String value) {
            addCriterion("DHLX >", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxGreaterThanOrEqualTo(String value) {
            addCriterion("DHLX >=", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxLessThan(String value) {
            addCriterion("DHLX <", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxLessThanOrEqualTo(String value) {
            addCriterion("DHLX <=", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxLike(String value) {
            addCriterion("DHLX like", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxNotLike(String value) {
            addCriterion("DHLX not like", value, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxIn(List<String> values) {
            addCriterion("DHLX in", values, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxNotIn(List<String> values) {
            addCriterion("DHLX not in", values, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxBetween(String value1, String value2) {
            addCriterion("DHLX between", value1, value2, "dhlx");
            return (Criteria) this;
        }

        public Criteria andDhlxNotBetween(String value1, String value2) {
            addCriterion("DHLX not between", value1, value2, "dhlx");
            return (Criteria) this;
        }

        public Criteria andCusttypeIsNull() {
            addCriterion("CUSTTYPE is null");
            return (Criteria) this;
        }

        public Criteria andCusttypeIsNotNull() {
            addCriterion("CUSTTYPE is not null");
            return (Criteria) this;
        }

        public Criteria andCusttypeEqualTo(Short value) {
            addCriterion("CUSTTYPE =", value, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeNotEqualTo(Short value) {
            addCriterion("CUSTTYPE <>", value, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeGreaterThan(Short value) {
            addCriterion("CUSTTYPE >", value, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeGreaterThanOrEqualTo(Short value) {
            addCriterion("CUSTTYPE >=", value, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeLessThan(Short value) {
            addCriterion("CUSTTYPE <", value, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeLessThanOrEqualTo(Short value) {
            addCriterion("CUSTTYPE <=", value, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeIn(List<Short> values) {
            addCriterion("CUSTTYPE in", values, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeNotIn(List<Short> values) {
            addCriterion("CUSTTYPE not in", values, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeBetween(Short value1, Short value2) {
            addCriterion("CUSTTYPE between", value1, value2, "custtype");
            return (Criteria) this;
        }

        public Criteria andCusttypeNotBetween(Short value1, Short value2) {
            addCriterion("CUSTTYPE not between", value1, value2, "custtype");
            return (Criteria) this;
        }

        public Criteria andJhjIdIsNull() {
            addCriterion("JHJ_ID is null");
            return (Criteria) this;
        }

        public Criteria andJhjIdIsNotNull() {
            addCriterion("JHJ_ID is not null");
            return (Criteria) this;
        }

        public Criteria andJhjIdEqualTo(Short value) {
            addCriterion("JHJ_ID =", value, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdNotEqualTo(Short value) {
            addCriterion("JHJ_ID <>", value, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdGreaterThan(Short value) {
            addCriterion("JHJ_ID >", value, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdGreaterThanOrEqualTo(Short value) {
            addCriterion("JHJ_ID >=", value, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdLessThan(Short value) {
            addCriterion("JHJ_ID <", value, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdLessThanOrEqualTo(Short value) {
            addCriterion("JHJ_ID <=", value, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdIn(List<Short> values) {
            addCriterion("JHJ_ID in", values, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdNotIn(List<Short> values) {
            addCriterion("JHJ_ID not in", values, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdBetween(Short value1, Short value2) {
            addCriterion("JHJ_ID between", value1, value2, "jhjId");
            return (Criteria) this;
        }

        public Criteria andJhjIdNotBetween(Short value1, Short value2) {
            addCriterion("JHJ_ID not between", value1, value2, "jhjId");
            return (Criteria) this;
        }

        public Criteria andDhgnIsNull() {
            addCriterion("DHGN is null");
            return (Criteria) this;
        }

        public Criteria andDhgnIsNotNull() {
            addCriterion("DHGN is not null");
            return (Criteria) this;
        }

        public Criteria andDhgnEqualTo(String value) {
            addCriterion("DHGN =", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnNotEqualTo(String value) {
            addCriterion("DHGN <>", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnGreaterThan(String value) {
            addCriterion("DHGN >", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnGreaterThanOrEqualTo(String value) {
            addCriterion("DHGN >=", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnLessThan(String value) {
            addCriterion("DHGN <", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnLessThanOrEqualTo(String value) {
            addCriterion("DHGN <=", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnLike(String value) {
            addCriterion("DHGN like", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnNotLike(String value) {
            addCriterion("DHGN not like", value, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnIn(List<String> values) {
            addCriterion("DHGN in", values, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnNotIn(List<String> values) {
            addCriterion("DHGN not in", values, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnBetween(String value1, String value2) {
            addCriterion("DHGN between", value1, value2, "dhgn");
            return (Criteria) this;
        }

        public Criteria andDhgnNotBetween(String value1, String value2) {
            addCriterion("DHGN not between", value1, value2, "dhgn");
            return (Criteria) this;
        }

        public Criteria andBz1IsNull() {
            addCriterion("BZ1 is null");
            return (Criteria) this;
        }

        public Criteria andBz1IsNotNull() {
            addCriterion("BZ1 is not null");
            return (Criteria) this;
        }

        public Criteria andBz1EqualTo(String value) {
            addCriterion("BZ1 =", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1NotEqualTo(String value) {
            addCriterion("BZ1 <>", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1GreaterThan(String value) {
            addCriterion("BZ1 >", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1GreaterThanOrEqualTo(String value) {
            addCriterion("BZ1 >=", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1LessThan(String value) {
            addCriterion("BZ1 <", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1LessThanOrEqualTo(String value) {
            addCriterion("BZ1 <=", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1Like(String value) {
            addCriterion("BZ1 like", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1NotLike(String value) {
            addCriterion("BZ1 not like", value, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1In(List<String> values) {
            addCriterion("BZ1 in", values, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1NotIn(List<String> values) {
            addCriterion("BZ1 not in", values, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1Between(String value1, String value2) {
            addCriterion("BZ1 between", value1, value2, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz1NotBetween(String value1, String value2) {
            addCriterion("BZ1 not between", value1, value2, "bz1");
            return (Criteria) this;
        }

        public Criteria andBz2IsNull() {
            addCriterion("BZ2 is null");
            return (Criteria) this;
        }

        public Criteria andBz2IsNotNull() {
            addCriterion("BZ2 is not null");
            return (Criteria) this;
        }

        public Criteria andBz2EqualTo(String value) {
            addCriterion("BZ2 =", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2NotEqualTo(String value) {
            addCriterion("BZ2 <>", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2GreaterThan(String value) {
            addCriterion("BZ2 >", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2GreaterThanOrEqualTo(String value) {
            addCriterion("BZ2 >=", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2LessThan(String value) {
            addCriterion("BZ2 <", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2LessThanOrEqualTo(String value) {
            addCriterion("BZ2 <=", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2Like(String value) {
            addCriterion("BZ2 like", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2NotLike(String value) {
            addCriterion("BZ2 not like", value, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2In(List<String> values) {
            addCriterion("BZ2 in", values, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2NotIn(List<String> values) {
            addCriterion("BZ2 not in", values, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2Between(String value1, String value2) {
            addCriterion("BZ2 between", value1, value2, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz2NotBetween(String value1, String value2) {
            addCriterion("BZ2 not between", value1, value2, "bz2");
            return (Criteria) this;
        }

        public Criteria andBz3IsNull() {
            addCriterion("BZ3 is null");
            return (Criteria) this;
        }

        public Criteria andBz3IsNotNull() {
            addCriterion("BZ3 is not null");
            return (Criteria) this;
        }

        public Criteria andBz3EqualTo(String value) {
            addCriterion("BZ3 =", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3NotEqualTo(String value) {
            addCriterion("BZ3 <>", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3GreaterThan(String value) {
            addCriterion("BZ3 >", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3GreaterThanOrEqualTo(String value) {
            addCriterion("BZ3 >=", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3LessThan(String value) {
            addCriterion("BZ3 <", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3LessThanOrEqualTo(String value) {
            addCriterion("BZ3 <=", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3Like(String value) {
            addCriterion("BZ3 like", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3NotLike(String value) {
            addCriterion("BZ3 not like", value, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3In(List<String> values) {
            addCriterion("BZ3 in", values, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3NotIn(List<String> values) {
            addCriterion("BZ3 not in", values, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3Between(String value1, String value2) {
            addCriterion("BZ3 between", value1, value2, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz3NotBetween(String value1, String value2) {
            addCriterion("BZ3 not between", value1, value2, "bz3");
            return (Criteria) this;
        }

        public Criteria andBz4IsNull() {
            addCriterion("BZ4 is null");
            return (Criteria) this;
        }

        public Criteria andBz4IsNotNull() {
            addCriterion("BZ4 is not null");
            return (Criteria) this;
        }

        public Criteria andBz4EqualTo(String value) {
            addCriterion("BZ4 =", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4NotEqualTo(String value) {
            addCriterion("BZ4 <>", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4GreaterThan(String value) {
            addCriterion("BZ4 >", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4GreaterThanOrEqualTo(String value) {
            addCriterion("BZ4 >=", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4LessThan(String value) {
            addCriterion("BZ4 <", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4LessThanOrEqualTo(String value) {
            addCriterion("BZ4 <=", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4Like(String value) {
            addCriterion("BZ4 like", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4NotLike(String value) {
            addCriterion("BZ4 not like", value, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4In(List<String> values) {
            addCriterion("BZ4 in", values, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4NotIn(List<String> values) {
            addCriterion("BZ4 not in", values, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4Between(String value1, String value2) {
            addCriterion("BZ4 between", value1, value2, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz4NotBetween(String value1, String value2) {
            addCriterion("BZ4 not between", value1, value2, "bz4");
            return (Criteria) this;
        }

        public Criteria andBz5IsNull() {
            addCriterion("BZ5 is null");
            return (Criteria) this;
        }

        public Criteria andBz5IsNotNull() {
            addCriterion("BZ5 is not null");
            return (Criteria) this;
        }

        public Criteria andBz5EqualTo(String value) {
            addCriterion("BZ5 =", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5NotEqualTo(String value) {
            addCriterion("BZ5 <>", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5GreaterThan(String value) {
            addCriterion("BZ5 >", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5GreaterThanOrEqualTo(String value) {
            addCriterion("BZ5 >=", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5LessThan(String value) {
            addCriterion("BZ5 <", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5LessThanOrEqualTo(String value) {
            addCriterion("BZ5 <=", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5Like(String value) {
            addCriterion("BZ5 like", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5NotLike(String value) {
            addCriterion("BZ5 not like", value, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5In(List<String> values) {
            addCriterion("BZ5 in", values, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5NotIn(List<String> values) {
            addCriterion("BZ5 not in", values, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5Between(String value1, String value2) {
            addCriterion("BZ5 between", value1, value2, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz5NotBetween(String value1, String value2) {
            addCriterion("BZ5 not between", value1, value2, "bz5");
            return (Criteria) this;
        }

        public Criteria andBz6IsNull() {
            addCriterion("BZ6 is null");
            return (Criteria) this;
        }

        public Criteria andBz6IsNotNull() {
            addCriterion("BZ6 is not null");
            return (Criteria) this;
        }

        public Criteria andBz6EqualTo(String value) {
            addCriterion("BZ6 =", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6NotEqualTo(String value) {
            addCriterion("BZ6 <>", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6GreaterThan(String value) {
            addCriterion("BZ6 >", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6GreaterThanOrEqualTo(String value) {
            addCriterion("BZ6 >=", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6LessThan(String value) {
            addCriterion("BZ6 <", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6LessThanOrEqualTo(String value) {
            addCriterion("BZ6 <=", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6Like(String value) {
            addCriterion("BZ6 like", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6NotLike(String value) {
            addCriterion("BZ6 not like", value, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6In(List<String> values) {
            addCriterion("BZ6 in", values, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6NotIn(List<String> values) {
            addCriterion("BZ6 not in", values, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6Between(String value1, String value2) {
            addCriterion("BZ6 between", value1, value2, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz6NotBetween(String value1, String value2) {
            addCriterion("BZ6 not between", value1, value2, "bz6");
            return (Criteria) this;
        }

        public Criteria andBz7IsNull() {
            addCriterion("BZ7 is null");
            return (Criteria) this;
        }

        public Criteria andBz7IsNotNull() {
            addCriterion("BZ7 is not null");
            return (Criteria) this;
        }

        public Criteria andBz7EqualTo(String value) {
            addCriterion("BZ7 =", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7NotEqualTo(String value) {
            addCriterion("BZ7 <>", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7GreaterThan(String value) {
            addCriterion("BZ7 >", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7GreaterThanOrEqualTo(String value) {
            addCriterion("BZ7 >=", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7LessThan(String value) {
            addCriterion("BZ7 <", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7LessThanOrEqualTo(String value) {
            addCriterion("BZ7 <=", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7Like(String value) {
            addCriterion("BZ7 like", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7NotLike(String value) {
            addCriterion("BZ7 not like", value, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7In(List<String> values) {
            addCriterion("BZ7 in", values, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7NotIn(List<String> values) {
            addCriterion("BZ7 not in", values, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7Between(String value1, String value2) {
            addCriterion("BZ7 between", value1, value2, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz7NotBetween(String value1, String value2) {
            addCriterion("BZ7 not between", value1, value2, "bz7");
            return (Criteria) this;
        }

        public Criteria andBz8IsNull() {
            addCriterion("BZ8 is null");
            return (Criteria) this;
        }

        public Criteria andBz8IsNotNull() {
            addCriterion("BZ8 is not null");
            return (Criteria) this;
        }

        public Criteria andBz8EqualTo(String value) {
            addCriterion("BZ8 =", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8NotEqualTo(String value) {
            addCriterion("BZ8 <>", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8GreaterThan(String value) {
            addCriterion("BZ8 >", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8GreaterThanOrEqualTo(String value) {
            addCriterion("BZ8 >=", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8LessThan(String value) {
            addCriterion("BZ8 <", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8LessThanOrEqualTo(String value) {
            addCriterion("BZ8 <=", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8Like(String value) {
            addCriterion("BZ8 like", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8NotLike(String value) {
            addCriterion("BZ8 not like", value, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8In(List<String> values) {
            addCriterion("BZ8 in", values, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8NotIn(List<String> values) {
            addCriterion("BZ8 not in", values, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8Between(String value1, String value2) {
            addCriterion("BZ8 between", value1, value2, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz8NotBetween(String value1, String value2) {
            addCriterion("BZ8 not between", value1, value2, "bz8");
            return (Criteria) this;
        }

        public Criteria andBz9IsNull() {
            addCriterion("BZ9 is null");
            return (Criteria) this;
        }

        public Criteria andBz9IsNotNull() {
            addCriterion("BZ9 is not null");
            return (Criteria) this;
        }

        public Criteria andBz9EqualTo(String value) {
            addCriterion("BZ9 =", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9NotEqualTo(String value) {
            addCriterion("BZ9 <>", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9GreaterThan(String value) {
            addCriterion("BZ9 >", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9GreaterThanOrEqualTo(String value) {
            addCriterion("BZ9 >=", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9LessThan(String value) {
            addCriterion("BZ9 <", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9LessThanOrEqualTo(String value) {
            addCriterion("BZ9 <=", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9Like(String value) {
            addCriterion("BZ9 like", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9NotLike(String value) {
            addCriterion("BZ9 not like", value, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9In(List<String> values) {
            addCriterion("BZ9 in", values, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9NotIn(List<String> values) {
            addCriterion("BZ9 not in", values, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9Between(String value1, String value2) {
            addCriterion("BZ9 between", value1, value2, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz9NotBetween(String value1, String value2) {
            addCriterion("BZ9 not between", value1, value2, "bz9");
            return (Criteria) this;
        }

        public Criteria andBz10IsNull() {
            addCriterion("BZ10 is null");
            return (Criteria) this;
        }

        public Criteria andBz10IsNotNull() {
            addCriterion("BZ10 is not null");
            return (Criteria) this;
        }

        public Criteria andBz10EqualTo(String value) {
            addCriterion("BZ10 =", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10NotEqualTo(String value) {
            addCriterion("BZ10 <>", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10GreaterThan(String value) {
            addCriterion("BZ10 >", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10GreaterThanOrEqualTo(String value) {
            addCriterion("BZ10 >=", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10LessThan(String value) {
            addCriterion("BZ10 <", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10LessThanOrEqualTo(String value) {
            addCriterion("BZ10 <=", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10Like(String value) {
            addCriterion("BZ10 like", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10NotLike(String value) {
            addCriterion("BZ10 not like", value, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10In(List<String> values) {
            addCriterion("BZ10 in", values, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10NotIn(List<String> values) {
            addCriterion("BZ10 not in", values, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10Between(String value1, String value2) {
            addCriterion("BZ10 between", value1, value2, "bz10");
            return (Criteria) this;
        }

        public Criteria andBz10NotBetween(String value1, String value2) {
            addCriterion("BZ10 not between", value1, value2, "bz10");
            return (Criteria) this;
        }

        public Criteria andMokuaijuIsNull() {
            addCriterion("MOKUAIJU is null");
            return (Criteria) this;
        }

        public Criteria andMokuaijuIsNotNull() {
            addCriterion("MOKUAIJU is not null");
            return (Criteria) this;
        }

        public Criteria andMokuaijuEqualTo(String value) {
            addCriterion("MOKUAIJU =", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuNotEqualTo(String value) {
            addCriterion("MOKUAIJU <>", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuGreaterThan(String value) {
            addCriterion("MOKUAIJU >", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuGreaterThanOrEqualTo(String value) {
            addCriterion("MOKUAIJU >=", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuLessThan(String value) {
            addCriterion("MOKUAIJU <", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuLessThanOrEqualTo(String value) {
            addCriterion("MOKUAIJU <=", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuLike(String value) {
            addCriterion("MOKUAIJU like", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuNotLike(String value) {
            addCriterion("MOKUAIJU not like", value, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuIn(List<String> values) {
            addCriterion("MOKUAIJU in", values, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuNotIn(List<String> values) {
            addCriterion("MOKUAIJU not in", values, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuBetween(String value1, String value2) {
            addCriterion("MOKUAIJU between", value1, value2, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andMokuaijuNotBetween(String value1, String value2) {
            addCriterion("MOKUAIJU not between", value1, value2, "mokuaiju");
            return (Criteria) this;
        }

        public Criteria andModualIsNull() {
            addCriterion("MODUAL is null");
            return (Criteria) this;
        }

        public Criteria andModualIsNotNull() {
            addCriterion("MODUAL is not null");
            return (Criteria) this;
        }

        public Criteria andModualEqualTo(String value) {
            addCriterion("MODUAL =", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualNotEqualTo(String value) {
            addCriterion("MODUAL <>", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualGreaterThan(String value) {
            addCriterion("MODUAL >", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualGreaterThanOrEqualTo(String value) {
            addCriterion("MODUAL >=", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualLessThan(String value) {
            addCriterion("MODUAL <", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualLessThanOrEqualTo(String value) {
            addCriterion("MODUAL <=", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualLike(String value) {
            addCriterion("MODUAL like", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualNotLike(String value) {
            addCriterion("MODUAL not like", value, "modual");
            return (Criteria) this;
        }

        public Criteria andModualIn(List<String> values) {
            addCriterion("MODUAL in", values, "modual");
            return (Criteria) this;
        }

        public Criteria andModualNotIn(List<String> values) {
            addCriterion("MODUAL not in", values, "modual");
            return (Criteria) this;
        }

        public Criteria andModualBetween(String value1, String value2) {
            addCriterion("MODUAL between", value1, value2, "modual");
            return (Criteria) this;
        }

        public Criteria andModualNotBetween(String value1, String value2) {
            addCriterion("MODUAL not between", value1, value2, "modual");
            return (Criteria) this;
        }

        public Criteria andPortIsNull() {
            addCriterion("PORT is null");
            return (Criteria) this;
        }

        public Criteria andPortIsNotNull() {
            addCriterion("PORT is not null");
            return (Criteria) this;
        }

        public Criteria andPortEqualTo(String value) {
            addCriterion("PORT =", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortNotEqualTo(String value) {
            addCriterion("PORT <>", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortGreaterThan(String value) {
            addCriterion("PORT >", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortGreaterThanOrEqualTo(String value) {
            addCriterion("PORT >=", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortLessThan(String value) {
            addCriterion("PORT <", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortLessThanOrEqualTo(String value) {
            addCriterion("PORT <=", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortLike(String value) {
            addCriterion("PORT like", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortNotLike(String value) {
            addCriterion("PORT not like", value, "port");
            return (Criteria) this;
        }

        public Criteria andPortIn(List<String> values) {
            addCriterion("PORT in", values, "port");
            return (Criteria) this;
        }

        public Criteria andPortNotIn(List<String> values) {
            addCriterion("PORT not in", values, "port");
            return (Criteria) this;
        }

        public Criteria andPortBetween(String value1, String value2) {
            addCriterion("PORT between", value1, value2, "port");
            return (Criteria) this;
        }

        public Criteria andPortNotBetween(String value1, String value2) {
            addCriterion("PORT not between", value1, value2, "port");
            return (Criteria) this;
        }

        public Criteria andTypenumIsNull() {
            addCriterion("TYPENUM is null");
            return (Criteria) this;
        }

        public Criteria andTypenumIsNotNull() {
            addCriterion("TYPENUM is not null");
            return (Criteria) this;
        }

        public Criteria andTypenumEqualTo(String value) {
            addCriterion("TYPENUM =", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumNotEqualTo(String value) {
            addCriterion("TYPENUM <>", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumGreaterThan(String value) {
            addCriterion("TYPENUM >", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumGreaterThanOrEqualTo(String value) {
            addCriterion("TYPENUM >=", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumLessThan(String value) {
            addCriterion("TYPENUM <", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumLessThanOrEqualTo(String value) {
            addCriterion("TYPENUM <=", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumLike(String value) {
            addCriterion("TYPENUM like", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumNotLike(String value) {
            addCriterion("TYPENUM not like", value, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumIn(List<String> values) {
            addCriterion("TYPENUM in", values, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumNotIn(List<String> values) {
            addCriterion("TYPENUM not in", values, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumBetween(String value1, String value2) {
            addCriterion("TYPENUM between", value1, value2, "typenum");
            return (Criteria) this;
        }

        public Criteria andTypenumNotBetween(String value1, String value2) {
            addCriterion("TYPENUM not between", value1, value2, "typenum");
            return (Criteria) this;
        }

        public Criteria andJbkzlxIsNull() {
            addCriterion("JBKZLX is null");
            return (Criteria) this;
        }

        public Criteria andJbkzlxIsNotNull() {
            addCriterion("JBKZLX is not null");
            return (Criteria) this;
        }

        public Criteria andJbkzlxEqualTo(String value) {
            addCriterion("JBKZLX =", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxNotEqualTo(String value) {
            addCriterion("JBKZLX <>", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxGreaterThan(String value) {
            addCriterion("JBKZLX >", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxGreaterThanOrEqualTo(String value) {
            addCriterion("JBKZLX >=", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxLessThan(String value) {
            addCriterion("JBKZLX <", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxLessThanOrEqualTo(String value) {
            addCriterion("JBKZLX <=", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxLike(String value) {
            addCriterion("JBKZLX like", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxNotLike(String value) {
            addCriterion("JBKZLX not like", value, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxIn(List<String> values) {
            addCriterion("JBKZLX in", values, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxNotIn(List<String> values) {
            addCriterion("JBKZLX not in", values, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxBetween(String value1, String value2) {
            addCriterion("JBKZLX between", value1, value2, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andJbkzlxNotBetween(String value1, String value2) {
            addCriterion("JBKZLX not between", value1, value2, "jbkzlx");
            return (Criteria) this;
        }

        public Criteria andYwareaIsNull() {
            addCriterion("YWAREA is null");
            return (Criteria) this;
        }

        public Criteria andYwareaIsNotNull() {
            addCriterion("YWAREA is not null");
            return (Criteria) this;
        }

        public Criteria andYwareaEqualTo(String value) {
            addCriterion("YWAREA =", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaNotEqualTo(String value) {
            addCriterion("YWAREA <>", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaGreaterThan(String value) {
            addCriterion("YWAREA >", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaGreaterThanOrEqualTo(String value) {
            addCriterion("YWAREA >=", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaLessThan(String value) {
            addCriterion("YWAREA <", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaLessThanOrEqualTo(String value) {
            addCriterion("YWAREA <=", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaLike(String value) {
            addCriterion("YWAREA like", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaNotLike(String value) {
            addCriterion("YWAREA not like", value, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaIn(List<String> values) {
            addCriterion("YWAREA in", values, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaNotIn(List<String> values) {
            addCriterion("YWAREA not in", values, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaBetween(String value1, String value2) {
            addCriterion("YWAREA between", value1, value2, "ywarea");
            return (Criteria) this;
        }

        public Criteria andYwareaNotBetween(String value1, String value2) {
            addCriterion("YWAREA not between", value1, value2, "ywarea");
            return (Criteria) this;
        }

        public Criteria andDhidIsNull() {
            addCriterion("DHID is null");
            return (Criteria) this;
        }

        public Criteria andDhidIsNotNull() {
            addCriterion("DHID is not null");
            return (Criteria) this;
        }

        public Criteria andDhidEqualTo(BigDecimal value) {
            addCriterion("DHID =", value, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidNotEqualTo(BigDecimal value) {
            addCriterion("DHID <>", value, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidGreaterThan(BigDecimal value) {
            addCriterion("DHID >", value, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("DHID >=", value, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidLessThan(BigDecimal value) {
            addCriterion("DHID <", value, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidLessThanOrEqualTo(BigDecimal value) {
            addCriterion("DHID <=", value, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidIn(List<BigDecimal> values) {
            addCriterion("DHID in", values, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidNotIn(List<BigDecimal> values) {
            addCriterion("DHID not in", values, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("DHID between", value1, value2, "dhid");
            return (Criteria) this;
        }

        public Criteria andDhidNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("DHID not between", value1, value2, "dhid");
            return (Criteria) this;
        }

        public Criteria andMobileIsNull() {
            addCriterion("MOBILE is null");
            return (Criteria) this;
        }

        public Criteria andMobileIsNotNull() {
            addCriterion("MOBILE is not null");
            return (Criteria) this;
        }

        public Criteria andMobileEqualTo(String value) {
            addCriterion("MOBILE =", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileNotEqualTo(String value) {
            addCriterion("MOBILE <>", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileGreaterThan(String value) {
            addCriterion("MOBILE >", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileGreaterThanOrEqualTo(String value) {
            addCriterion("MOBILE >=", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileLessThan(String value) {
            addCriterion("MOBILE <", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileLessThanOrEqualTo(String value) {
            addCriterion("MOBILE <=", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileLike(String value) {
            addCriterion("MOBILE like", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileNotLike(String value) {
            addCriterion("MOBILE not like", value, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileIn(List<String> values) {
            addCriterion("MOBILE in", values, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileNotIn(List<String> values) {
            addCriterion("MOBILE not in", values, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileBetween(String value1, String value2) {
            addCriterion("MOBILE between", value1, value2, "mobile");
            return (Criteria) this;
        }

        public Criteria andMobileNotBetween(String value1, String value2) {
            addCriterion("MOBILE not between", value1, value2, "mobile");
            return (Criteria) this;
        }

        public Criteria andCreditgradeIsNull() {
            addCriterion("CREDITGRADE is null");
            return (Criteria) this;
        }

        public Criteria andCreditgradeIsNotNull() {
            addCriterion("CREDITGRADE is not null");
            return (Criteria) this;
        }

        public Criteria andCreditgradeEqualTo(Short value) {
            addCriterion("CREDITGRADE =", value, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeNotEqualTo(Short value) {
            addCriterion("CREDITGRADE <>", value, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeGreaterThan(Short value) {
            addCriterion("CREDITGRADE >", value, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeGreaterThanOrEqualTo(Short value) {
            addCriterion("CREDITGRADE >=", value, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeLessThan(Short value) {
            addCriterion("CREDITGRADE <", value, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeLessThanOrEqualTo(Short value) {
            addCriterion("CREDITGRADE <=", value, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeIn(List<Short> values) {
            addCriterion("CREDITGRADE in", values, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeNotIn(List<Short> values) {
            addCriterion("CREDITGRADE not in", values, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeBetween(Short value1, Short value2) {
            addCriterion("CREDITGRADE between", value1, value2, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditgradeNotBetween(Short value1, Short value2) {
            addCriterion("CREDITGRADE not between", value1, value2, "creditgrade");
            return (Criteria) this;
        }

        public Criteria andCreditpointIsNull() {
            addCriterion("CREDITPOINT is null");
            return (Criteria) this;
        }

        public Criteria andCreditpointIsNotNull() {
            addCriterion("CREDITPOINT is not null");
            return (Criteria) this;
        }

        public Criteria andCreditpointEqualTo(Integer value) {
            addCriterion("CREDITPOINT =", value, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointNotEqualTo(Integer value) {
            addCriterion("CREDITPOINT <>", value, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointGreaterThan(Integer value) {
            addCriterion("CREDITPOINT >", value, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointGreaterThanOrEqualTo(Integer value) {
            addCriterion("CREDITPOINT >=", value, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointLessThan(Integer value) {
            addCriterion("CREDITPOINT <", value, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointLessThanOrEqualTo(Integer value) {
            addCriterion("CREDITPOINT <=", value, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointIn(List<Integer> values) {
            addCriterion("CREDITPOINT in", values, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointNotIn(List<Integer> values) {
            addCriterion("CREDITPOINT not in", values, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointBetween(Integer value1, Integer value2) {
            addCriterion("CREDITPOINT between", value1, value2, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andCreditpointNotBetween(Integer value1, Integer value2) {
            addCriterion("CREDITPOINT not between", value1, value2, "creditpoint");
            return (Criteria) this;
        }

        public Criteria andUsertypeIsNull() {
            addCriterion("USERTYPE is null");
            return (Criteria) this;
        }

        public Criteria andUsertypeIsNotNull() {
            addCriterion("USERTYPE is not null");
            return (Criteria) this;
        }

        public Criteria andUsertypeEqualTo(Long value) {
            addCriterion("USERTYPE =", value, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeNotEqualTo(Long value) {
            addCriterion("USERTYPE <>", value, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeGreaterThan(Long value) {
            addCriterion("USERTYPE >", value, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeGreaterThanOrEqualTo(Long value) {
            addCriterion("USERTYPE >=", value, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeLessThan(Long value) {
            addCriterion("USERTYPE <", value, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeLessThanOrEqualTo(Long value) {
            addCriterion("USERTYPE <=", value, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeIn(List<Long> values) {
            addCriterion("USERTYPE in", values, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeNotIn(List<Long> values) {
            addCriterion("USERTYPE not in", values, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeBetween(Long value1, Long value2) {
            addCriterion("USERTYPE between", value1, value2, "usertype");
            return (Criteria) this;
        }

        public Criteria andUsertypeNotBetween(Long value1, Long value2) {
            addCriterion("USERTYPE not between", value1, value2, "usertype");
            return (Criteria) this;
        }

        public Criteria andServiceareaIsNull() {
            addCriterion("SERVICEAREA is null");
            return (Criteria) this;
        }

        public Criteria andServiceareaIsNotNull() {
            addCriterion("SERVICEAREA is not null");
            return (Criteria) this;
        }

        public Criteria andServiceareaEqualTo(Long value) {
            addCriterion("SERVICEAREA =", value, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaNotEqualTo(Long value) {
            addCriterion("SERVICEAREA <>", value, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaGreaterThan(Long value) {
            addCriterion("SERVICEAREA >", value, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaGreaterThanOrEqualTo(Long value) {
            addCriterion("SERVICEAREA >=", value, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaLessThan(Long value) {
            addCriterion("SERVICEAREA <", value, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaLessThanOrEqualTo(Long value) {
            addCriterion("SERVICEAREA <=", value, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaIn(List<Long> values) {
            addCriterion("SERVICEAREA in", values, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaNotIn(List<Long> values) {
            addCriterion("SERVICEAREA not in", values, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaBetween(Long value1, Long value2) {
            addCriterion("SERVICEAREA between", value1, value2, "servicearea");
            return (Criteria) this;
        }

        public Criteria andServiceareaNotBetween(Long value1, Long value2) {
            addCriterion("SERVICEAREA not between", value1, value2, "servicearea");
            return (Criteria) this;
        }

        public Criteria andMkj2IsNull() {
            addCriterion("MKJ2 is null");
            return (Criteria) this;
        }

        public Criteria andMkj2IsNotNull() {
            addCriterion("MKJ2 is not null");
            return (Criteria) this;
        }

        public Criteria andMkj2EqualTo(String value) {
            addCriterion("MKJ2 =", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2NotEqualTo(String value) {
            addCriterion("MKJ2 <>", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2GreaterThan(String value) {
            addCriterion("MKJ2 >", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2GreaterThanOrEqualTo(String value) {
            addCriterion("MKJ2 >=", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2LessThan(String value) {
            addCriterion("MKJ2 <", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2LessThanOrEqualTo(String value) {
            addCriterion("MKJ2 <=", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2Like(String value) {
            addCriterion("MKJ2 like", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2NotLike(String value) {
            addCriterion("MKJ2 not like", value, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2In(List<String> values) {
            addCriterion("MKJ2 in", values, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2NotIn(List<String> values) {
            addCriterion("MKJ2 not in", values, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2Between(String value1, String value2) {
            addCriterion("MKJ2 between", value1, value2, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj2NotBetween(String value1, String value2) {
            addCriterion("MKJ2 not between", value1, value2, "mkj2");
            return (Criteria) this;
        }

        public Criteria andMkj3IsNull() {
            addCriterion("MKJ3 is null");
            return (Criteria) this;
        }

        public Criteria andMkj3IsNotNull() {
            addCriterion("MKJ3 is not null");
            return (Criteria) this;
        }

        public Criteria andMkj3EqualTo(String value) {
            addCriterion("MKJ3 =", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3NotEqualTo(String value) {
            addCriterion("MKJ3 <>", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3GreaterThan(String value) {
            addCriterion("MKJ3 >", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3GreaterThanOrEqualTo(String value) {
            addCriterion("MKJ3 >=", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3LessThan(String value) {
            addCriterion("MKJ3 <", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3LessThanOrEqualTo(String value) {
            addCriterion("MKJ3 <=", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3Like(String value) {
            addCriterion("MKJ3 like", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3NotLike(String value) {
            addCriterion("MKJ3 not like", value, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3In(List<String> values) {
            addCriterion("MKJ3 in", values, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3NotIn(List<String> values) {
            addCriterion("MKJ3 not in", values, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3Between(String value1, String value2) {
            addCriterion("MKJ3 between", value1, value2, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj3NotBetween(String value1, String value2) {
            addCriterion("MKJ3 not between", value1, value2, "mkj3");
            return (Criteria) this;
        }

        public Criteria andMkj4IsNull() {
            addCriterion("MKJ4 is null");
            return (Criteria) this;
        }

        public Criteria andMkj4IsNotNull() {
            addCriterion("MKJ4 is not null");
            return (Criteria) this;
        }

        public Criteria andMkj4EqualTo(String value) {
            addCriterion("MKJ4 =", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4NotEqualTo(String value) {
            addCriterion("MKJ4 <>", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4GreaterThan(String value) {
            addCriterion("MKJ4 >", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4GreaterThanOrEqualTo(String value) {
            addCriterion("MKJ4 >=", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4LessThan(String value) {
            addCriterion("MKJ4 <", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4LessThanOrEqualTo(String value) {
            addCriterion("MKJ4 <=", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4Like(String value) {
            addCriterion("MKJ4 like", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4NotLike(String value) {
            addCriterion("MKJ4 not like", value, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4In(List<String> values) {
            addCriterion("MKJ4 in", values, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4NotIn(List<String> values) {
            addCriterion("MKJ4 not in", values, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4Between(String value1, String value2) {
            addCriterion("MKJ4 between", value1, value2, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkj4NotBetween(String value1, String value2) {
            addCriterion("MKJ4 not between", value1, value2, "mkj4");
            return (Criteria) this;
        }

        public Criteria andMkjacrossIsNull() {
            addCriterion("MKJACROSS is null");
            return (Criteria) this;
        }

        public Criteria andMkjacrossIsNotNull() {
            addCriterion("MKJACROSS is not null");
            return (Criteria) this;
        }

        public Criteria andMkjacrossEqualTo(Integer value) {
            addCriterion("MKJACROSS =", value, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossNotEqualTo(Integer value) {
            addCriterion("MKJACROSS <>", value, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossGreaterThan(Integer value) {
            addCriterion("MKJACROSS >", value, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossGreaterThanOrEqualTo(Integer value) {
            addCriterion("MKJACROSS >=", value, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossLessThan(Integer value) {
            addCriterion("MKJACROSS <", value, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossLessThanOrEqualTo(Integer value) {
            addCriterion("MKJACROSS <=", value, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossIn(List<Integer> values) {
            addCriterion("MKJACROSS in", values, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossNotIn(List<Integer> values) {
            addCriterion("MKJACROSS not in", values, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossBetween(Integer value1, Integer value2) {
            addCriterion("MKJACROSS between", value1, value2, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andMkjacrossNotBetween(Integer value1, Integer value2) {
            addCriterion("MKJACROSS not between", value1, value2, "mkjacross");
            return (Criteria) this;
        }

        public Criteria andFjdateIsNull() {
            addCriterion("FJDATE is null");
            return (Criteria) this;
        }

        public Criteria andFjdateIsNotNull() {
            addCriterion("FJDATE is not null");
            return (Criteria) this;
        }

        public Criteria andFjdateEqualTo(Date value) {
            addCriterionForJDBCDate("FJDATE =", value, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateNotEqualTo(Date value) {
            addCriterionForJDBCDate("FJDATE <>", value, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateGreaterThan(Date value) {
            addCriterionForJDBCDate("FJDATE >", value, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("FJDATE >=", value, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateLessThan(Date value) {
            addCriterionForJDBCDate("FJDATE <", value, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("FJDATE <=", value, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateIn(List<Date> values) {
            addCriterionForJDBCDate("FJDATE in", values, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateNotIn(List<Date> values) {
            addCriterionForJDBCDate("FJDATE not in", values, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("FJDATE between", value1, value2, "fjdate");
            return (Criteria) this;
        }

        public Criteria andFjdateNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("FJDATE not between", value1, value2, "fjdate");
            return (Criteria) this;
        }

        public Criteria andStartdzIsNull() {
            addCriterion("STARTDZ is null");
            return (Criteria) this;
        }

        public Criteria andStartdzIsNotNull() {
            addCriterion("STARTDZ is not null");
            return (Criteria) this;
        }

        public Criteria andStartdzEqualTo(String value) {
            addCriterion("STARTDZ =", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzNotEqualTo(String value) {
            addCriterion("STARTDZ <>", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzGreaterThan(String value) {
            addCriterion("STARTDZ >", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzGreaterThanOrEqualTo(String value) {
            addCriterion("STARTDZ >=", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzLessThan(String value) {
            addCriterion("STARTDZ <", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzLessThanOrEqualTo(String value) {
            addCriterion("STARTDZ <=", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzLike(String value) {
            addCriterion("STARTDZ like", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzNotLike(String value) {
            addCriterion("STARTDZ not like", value, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzIn(List<String> values) {
            addCriterion("STARTDZ in", values, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzNotIn(List<String> values) {
            addCriterion("STARTDZ not in", values, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzBetween(String value1, String value2) {
            addCriterion("STARTDZ between", value1, value2, "startdz");
            return (Criteria) this;
        }

        public Criteria andStartdzNotBetween(String value1, String value2) {
            addCriterion("STARTDZ not between", value1, value2, "startdz");
            return (Criteria) this;
        }

        public Criteria andEnddzIsNull() {
            addCriterion("ENDDZ is null");
            return (Criteria) this;
        }
        
        public Criteria andRownum(){
        	addCriterion("rownum = 1");
        	return (Criteria) this;
        }
        
        public Criteria andEnddzIsNotNull() {
            addCriterion("ENDDZ is not null");
            return (Criteria) this;
        }

        public Criteria andEnddzEqualTo(String value) {
            addCriterion("ENDDZ =", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzNotEqualTo(String value) {
            addCriterion("ENDDZ <>", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzGreaterThan(String value) {
            addCriterion("ENDDZ >", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzGreaterThanOrEqualTo(String value) {
            addCriterion("ENDDZ >=", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzLessThan(String value) {
            addCriterion("ENDDZ <", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzLessThanOrEqualTo(String value) {
            addCriterion("ENDDZ <=", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzLike(String value) {
            addCriterion("ENDDZ like", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzNotLike(String value) {
            addCriterion("ENDDZ not like", value, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzIn(List<String> values) {
            addCriterion("ENDDZ in", values, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzNotIn(List<String> values) {
            addCriterion("ENDDZ not in", values, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzBetween(String value1, String value2) {
            addCriterion("ENDDZ between", value1, value2, "enddz");
            return (Criteria) this;
        }

        public Criteria andEnddzNotBetween(String value1, String value2) {
            addCriterion("ENDDZ not between", value1, value2, "enddz");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}