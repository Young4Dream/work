package com.tboss.ssm.po;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TBsMenuInfoExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public TBsMenuInfoExample() {
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

        public Criteria andMenuIdIsNull() {
            addCriterion("MENU_ID is null");
            return (Criteria) this;
        }

        public Criteria andMenuIdIsNotNull() {
            addCriterion("MENU_ID is not null");
            return (Criteria) this;
        }

        public Criteria andMenuIdEqualTo(BigDecimal value) {
            addCriterion("MENU_ID =", value, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdNotEqualTo(BigDecimal value) {
            addCriterion("MENU_ID <>", value, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdGreaterThan(BigDecimal value) {
            addCriterion("MENU_ID >", value, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("MENU_ID >=", value, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdLessThan(BigDecimal value) {
            addCriterion("MENU_ID <", value, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdLessThanOrEqualTo(BigDecimal value) {
            addCriterion("MENU_ID <=", value, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdIn(List<BigDecimal> values) {
            addCriterion("MENU_ID in", values, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdNotIn(List<BigDecimal> values) {
            addCriterion("MENU_ID not in", values, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("MENU_ID between", value1, value2, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuIdNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("MENU_ID not between", value1, value2, "menuId");
            return (Criteria) this;
        }

        public Criteria andMenuNameIsNull() {
            addCriterion("MENU_NAME is null");
            return (Criteria) this;
        }

        public Criteria andMenuNameIsNotNull() {
            addCriterion("MENU_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andMenuNameEqualTo(String value) {
            addCriterion("MENU_NAME =", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameNotEqualTo(String value) {
            addCriterion("MENU_NAME <>", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameGreaterThan(String value) {
            addCriterion("MENU_NAME >", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameGreaterThanOrEqualTo(String value) {
            addCriterion("MENU_NAME >=", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameLessThan(String value) {
            addCriterion("MENU_NAME <", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameLessThanOrEqualTo(String value) {
            addCriterion("MENU_NAME <=", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameLike(String value) {
            addCriterion("MENU_NAME like", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameNotLike(String value) {
            addCriterion("MENU_NAME not like", value, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameIn(List<String> values) {
            addCriterion("MENU_NAME in", values, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameNotIn(List<String> values) {
            addCriterion("MENU_NAME not in", values, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameBetween(String value1, String value2) {
            addCriterion("MENU_NAME between", value1, value2, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuNameNotBetween(String value1, String value2) {
            addCriterion("MENU_NAME not between", value1, value2, "menuName");
            return (Criteria) this;
        }

        public Criteria andMenuDescIsNull() {
            addCriterion("MENU_DESC is null");
            return (Criteria) this;
        }

        public Criteria andMenuDescIsNotNull() {
            addCriterion("MENU_DESC is not null");
            return (Criteria) this;
        }

        public Criteria andMenuDescEqualTo(String value) {
            addCriterion("MENU_DESC =", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescNotEqualTo(String value) {
            addCriterion("MENU_DESC <>", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescGreaterThan(String value) {
            addCriterion("MENU_DESC >", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescGreaterThanOrEqualTo(String value) {
            addCriterion("MENU_DESC >=", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescLessThan(String value) {
            addCriterion("MENU_DESC <", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescLessThanOrEqualTo(String value) {
            addCriterion("MENU_DESC <=", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescLike(String value) {
            addCriterion("MENU_DESC like", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescNotLike(String value) {
            addCriterion("MENU_DESC not like", value, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescIn(List<String> values) {
            addCriterion("MENU_DESC in", values, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescNotIn(List<String> values) {
            addCriterion("MENU_DESC not in", values, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescBetween(String value1, String value2) {
            addCriterion("MENU_DESC between", value1, value2, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuDescNotBetween(String value1, String value2) {
            addCriterion("MENU_DESC not between", value1, value2, "menuDesc");
            return (Criteria) this;
        }

        public Criteria andMenuIcoIsNull() {
            addCriterion("MENU_ICO is null");
            return (Criteria) this;
        }

        public Criteria andMenuIcoIsNotNull() {
            addCriterion("MENU_ICO is not null");
            return (Criteria) this;
        }

        public Criteria andMenuIcoEqualTo(String value) {
            addCriterion("MENU_ICO =", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoNotEqualTo(String value) {
            addCriterion("MENU_ICO <>", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoGreaterThan(String value) {
            addCriterion("MENU_ICO >", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoGreaterThanOrEqualTo(String value) {
            addCriterion("MENU_ICO >=", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoLessThan(String value) {
            addCriterion("MENU_ICO <", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoLessThanOrEqualTo(String value) {
            addCriterion("MENU_ICO <=", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoLike(String value) {
            addCriterion("MENU_ICO like", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoNotLike(String value) {
            addCriterion("MENU_ICO not like", value, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoIn(List<String> values) {
            addCriterion("MENU_ICO in", values, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoNotIn(List<String> values) {
            addCriterion("MENU_ICO not in", values, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoBetween(String value1, String value2) {
            addCriterion("MENU_ICO between", value1, value2, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuIcoNotBetween(String value1, String value2) {
            addCriterion("MENU_ICO not between", value1, value2, "menuIco");
            return (Criteria) this;
        }

        public Criteria andMenuUrlIsNull() {
            addCriterion("MENU_URL is null");
            return (Criteria) this;
        }

        public Criteria andMenuUrlIsNotNull() {
            addCriterion("MENU_URL is not null");
            return (Criteria) this;
        }

        public Criteria andMenuUrlEqualTo(String value) {
            addCriterion("MENU_URL =", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlNotEqualTo(String value) {
            addCriterion("MENU_URL <>", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlGreaterThan(String value) {
            addCriterion("MENU_URL >", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlGreaterThanOrEqualTo(String value) {
            addCriterion("MENU_URL >=", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlLessThan(String value) {
            addCriterion("MENU_URL <", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlLessThanOrEqualTo(String value) {
            addCriterion("MENU_URL <=", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlLike(String value) {
            addCriterion("MENU_URL like", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlNotLike(String value) {
            addCriterion("MENU_URL not like", value, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlIn(List<String> values) {
            addCriterion("MENU_URL in", values, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlNotIn(List<String> values) {
            addCriterion("MENU_URL not in", values, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlBetween(String value1, String value2) {
            addCriterion("MENU_URL between", value1, value2, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andMenuUrlNotBetween(String value1, String value2) {
            addCriterion("MENU_URL not between", value1, value2, "menuUrl");
            return (Criteria) this;
        }

        public Criteria andParentIdIsNull() {
            addCriterion("PARENT_ID is null");
            return (Criteria) this;
        }

        public Criteria andParentIdIsNotNull() {
            addCriterion("PARENT_ID is not null");
            return (Criteria) this;
        }

        public Criteria andParentIdEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID =", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdNotEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID <>", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdGreaterThan(BigDecimal value) {
            addCriterion("PARENT_ID >", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID >=", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdLessThan(BigDecimal value) {
            addCriterion("PARENT_ID <", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdLessThanOrEqualTo(BigDecimal value) {
            addCriterion("PARENT_ID <=", value, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdIn(List<BigDecimal> values) {
            addCriterion("PARENT_ID in", values, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdNotIn(List<BigDecimal> values) {
            addCriterion("PARENT_ID not in", values, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("PARENT_ID between", value1, value2, "parentId");
            return (Criteria) this;
        }

        public Criteria andParentIdNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("PARENT_ID not between", value1, value2, "parentId");
            return (Criteria) this;
        }

        public Criteria andMenuSortIsNull() {
            addCriterion("MENU_SORT is null");
            return (Criteria) this;
        }

        public Criteria andMenuSortIsNotNull() {
            addCriterion("MENU_SORT is not null");
            return (Criteria) this;
        }

        public Criteria andMenuSortEqualTo(BigDecimal value) {
            addCriterion("MENU_SORT =", value, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortNotEqualTo(BigDecimal value) {
            addCriterion("MENU_SORT <>", value, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortGreaterThan(BigDecimal value) {
            addCriterion("MENU_SORT >", value, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("MENU_SORT >=", value, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortLessThan(BigDecimal value) {
            addCriterion("MENU_SORT <", value, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortLessThanOrEqualTo(BigDecimal value) {
            addCriterion("MENU_SORT <=", value, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortIn(List<BigDecimal> values) {
            addCriterion("MENU_SORT in", values, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortNotIn(List<BigDecimal> values) {
            addCriterion("MENU_SORT not in", values, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("MENU_SORT between", value1, value2, "menuSort");
            return (Criteria) this;
        }

        public Criteria andMenuSortNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("MENU_SORT not between", value1, value2, "menuSort");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNull() {
            addCriterion("CREATE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNotNull() {
            addCriterion("CREATE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeEqualTo(Date value) {
            addCriterion("CREATE_TIME =", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotEqualTo(Date value) {
            addCriterion("CREATE_TIME <>", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThan(Date value) {
            addCriterion("CREATE_TIME >", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("CREATE_TIME >=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThan(Date value) {
            addCriterion("CREATE_TIME <", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThanOrEqualTo(Date value) {
            addCriterion("CREATE_TIME <=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIn(List<Date> values) {
            addCriterion("CREATE_TIME in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotIn(List<Date> values) {
            addCriterion("CREATE_TIME not in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeBetween(Date value1, Date value2) {
            addCriterion("CREATE_TIME between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotBetween(Date value1, Date value2) {
            addCriterion("CREATE_TIME not between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeIsNull() {
            addCriterion("UPDATE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeIsNotNull() {
            addCriterion("UPDATE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeEqualTo(Date value) {
            addCriterion("UPDATE_TIME =", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeNotEqualTo(Date value) {
            addCriterion("UPDATE_TIME <>", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeGreaterThan(Date value) {
            addCriterion("UPDATE_TIME >", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("UPDATE_TIME >=", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeLessThan(Date value) {
            addCriterion("UPDATE_TIME <", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeLessThanOrEqualTo(Date value) {
            addCriterion("UPDATE_TIME <=", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeIn(List<Date> values) {
            addCriterion("UPDATE_TIME in", values, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeNotIn(List<Date> values) {
            addCriterion("UPDATE_TIME not in", values, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeBetween(Date value1, Date value2) {
            addCriterion("UPDATE_TIME between", value1, value2, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeNotBetween(Date value1, Date value2) {
            addCriterion("UPDATE_TIME not between", value1, value2, "updateTime");
            return (Criteria) this;
        }

        public Criteria andRemarkIsNull() {
            addCriterion("REMARK is null");
            return (Criteria) this;
        }

        public Criteria andRemarkIsNotNull() {
            addCriterion("REMARK is not null");
            return (Criteria) this;
        }

        public Criteria andRemarkEqualTo(String value) {
            addCriterion("REMARK =", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotEqualTo(String value) {
            addCriterion("REMARK <>", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkGreaterThan(String value) {
            addCriterion("REMARK >", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkGreaterThanOrEqualTo(String value) {
            addCriterion("REMARK >=", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLessThan(String value) {
            addCriterion("REMARK <", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLessThanOrEqualTo(String value) {
            addCriterion("REMARK <=", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLike(String value) {
            addCriterion("REMARK like", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotLike(String value) {
            addCriterion("REMARK not like", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkIn(List<String> values) {
            addCriterion("REMARK in", values, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotIn(List<String> values) {
            addCriterion("REMARK not in", values, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkBetween(String value1, String value2) {
            addCriterion("REMARK between", value1, value2, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotBetween(String value1, String value2) {
            addCriterion("REMARK not between", value1, value2, "remark");
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