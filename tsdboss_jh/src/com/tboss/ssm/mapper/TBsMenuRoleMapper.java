package com.tboss.ssm.mapper;

import com.tboss.ssm.po.TBsMenuRole;
import com.tboss.ssm.po.TBsMenuRoleExample;
import java.math.BigDecimal;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TBsMenuRoleMapper {
    int countByExample(TBsMenuRoleExample example);

    int deleteByExample(TBsMenuRoleExample example);

    int deleteByPrimaryKey(BigDecimal id);

    int insert(TBsMenuRole record);

    int insertSelective(TBsMenuRole record);

    List<TBsMenuRole> selectByExample(TBsMenuRoleExample example);

    TBsMenuRole selectByPrimaryKey(BigDecimal id);

    int updateByExampleSelective(@Param("record") TBsMenuRole record, @Param("example") TBsMenuRoleExample example);

    int updateByExample(@Param("record") TBsMenuRole record, @Param("example") TBsMenuRoleExample example);

    int updateByPrimaryKeySelective(TBsMenuRole record);

    int updateByPrimaryKey(TBsMenuRole record);
}